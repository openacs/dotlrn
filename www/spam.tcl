#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 19, 2002
    @version $Id$
} -query {
    {recipients:integer,multiple ""}
    {recipients_str ""}
    {community_id ""}
    {rel_types:multiple "" }
    {rel_types_str ""}
    {referer "control-panel"}
    {spam_all 0}
} -validate {

   recipients_split {
       if { [info exists recipients_str] && ![info exists recipients] } {
            set recipients [split $recipients_str]
       }
   }

    rel_types_split {
        if { [info exists rel_types_str] && ![info exists rel_types] } {
            set rel_types [split $rel_types_str]
        }
    }

    recipients_specified {
 
	set recipients_p 0
        if {[info exists rel_types] && ![empty_string_p $rel_types]} {
            set recipients_p 1
        } elseif  {[info exists recipients] && ![empty_string_p $recipients]} {
            set recipients_p 1
        } elseif {[info exists spam_all] && $spam_all != 0} {
            set recipients_p 1
        } elseif { [info exists rel_types_str] && ![empty_string_p rel_types_str] } {
            set recipients_p 1
        } elseif { [info exists recipients_str] && ![empty_string_p recipients_str] } {
            set recipients_p 1
        }

        if { $recipients_p == 0} {
            ad_complain "[_ dotlrn.Must_specify_recipients]"
        }
    }

} -properties {
    context_bar:onevalue
    portal_id:onevalue
}

set spam_name [bulk_mail::parameter -parameter PrettyName -default [_ dotlrn.Spam]]
set context_bar [list [list $referer [_ dotlrn.Admin]] "$spam_name [_ dotlrn.Community]"]

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_spam_community -community_id $community_id

set sender_id [ad_conn user_id]
set portal_id [dotlrn_community::get_portal_id -community_id $community_id]

db_1row select_sender_info {}

# names can have single quotes in them, and since they are being selected
# from the database as literals down below, when the sender_info query is
# passed to bulk_mail::new, we have to make sure they are properly quoted
set sender_first_names [db_quote $sender_first_names]
set sender_last_name [db_quote $sender_last_name]

form create spam_message

element create spam_message community_id \
    -label "[_ dotlrn.Community_ID]" \
    -datatype integer \
    -widget hidden \
    -value $community_id

element create spam_message from \
    -label [_ dotlrn.From] \
    -datatype text \
    -widget hidden \
    -html {size 60} \
    -value $sender_email

element create spam_message subject \
    -label [_ dotlrn.Subject] \
    -datatype text \
    -widget text \
    -html {size 60}

element create spam_message message \
    -label [_ dotlrn.Message] \
    -datatype text \
    -widget textarea \
    -html {rows 10 cols 80 wrap soft}


element create spam_message format \
    -label "Format" \
    -datatype text \
    -widget select \
    -options {{"Preformatted Text" "pre"} {"Plain Text" "plain"} {HTML "html"}}


element create spam_message send_date \
    -label [_ dotlrn.Send_Date] \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY HH12 MI AM} \
    -value [template::util::date::now_min_interval]

element create spam_message referer \
    -label [_ dotlrn.Referer] \
    -datatype text \
    -widget hidden \
    -value $referer

element create spam_message recipients_str \
    -label Recipients \
    -datatype text \
    -widget hidden \
    -value $recipients

element create spam_message rel_types_str \
    -label rel_types \
    -datatype text \
    -widget hidden \
    -value $rel_types

element create spam_message spam_all \
    -label spam \
    -datatype text \
    -widget hidden \
    -value $spam_all

if {[ns_queryexists "form:confirm"]} {
    form get_values spam_message \
        community_id from rel_types_str subject message send_date referer recipients_str spam_all format
   
    set community_name [dotlrn_community::get_community_name $community_id]
    set community_url "[ad_parameter -package_id [ad_acs_kernel_id] SystemURL][dotlrn_community::get_community_url $community_id]"

    set recipients_str [join [split $recipients_str] ,]
    set rel_types_str [join [split $rel_types_str] ',']


# POSTGRES - change to plural
# TODO - what if no rel_types

    set safe_community_name [db_quote $community_name]

    set extra_where_clause ""

    if { $spam_all } {
	# if there is a spam_all, choose all the rel_types!

	set rel_types_str [join [db_list select_rel_segments "
            select rel_segments.rel_type
            from rel_segments
            where rel_segments.group_id = :community_id"] ',']
    } 

    if {[empty_string_p $recipients_str]} {
	set recipients_str ''
    }

    if {![string equal $rel_types_str ''] && [string equal $recipients_str ''] } {
    set query_restriction "and acs_rels.rel_type in ('$rel_types_str')"
    } elseif {[string equal $rel_types_str ''] && ![string equal $recipients_str ''] } {
    set query_restriction "and acs_rels.object_id_two in ($recipients_str)"
    } elseif {![string equal $rel_types_str ''] && ![string equal $recipients_str ''] } {
    set query_restriction "and (acs_rels.rel_type in ('$rel_types_str') or acs_rels.object_id_two in ($recipients_str))"
    } 

    set query [db_map sender_info]

    if {$format == "html"} {
	set message "$message"
	set message_type "html"
    } elseif {$format == "pre"} {
	set message [ad_text_to_html $message]
	set message_type "html"
    } else {
	set message [ad_quotehtml $message]
	set message_type "text"
    }

    bulk_mail::new \
        -package_id [site_node_apm_integration::get_child_package_id -package_key [bulk_mail::package_key]] \
        -send_date [template::util::date::get_property linear_date $send_date] \
        -date_format "YYYY MM DD HH24 MI SS" \
        -from_addr $from \
        -subject "\[$community_name\] $subject" \
        -message $message \
        -message_type $message_type \
        -query $query

    ad_returnredirect $referer
    ad_script_abort
}

if {[form is_valid spam_message]} {

    set confirm_data [form export]
    append confirm_data {<input type="hidden" name="form:confirm" value="confirm">}
    template::set_file "[file dir $__adp_stub]/spam-2"

}

ad_return_template

