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
    {community_id ""}
    {rel_type "dotlrn_member_rel"}
    {referer "control-panel"}
} -properties {
    context_bar:onevalue
    portal_id:onevalue
}

set spam_name [bulk_mail::parameter -parameter PrettyName -default Spam]
set context_bar [list [list $referer [_ dotlrn.Admin]] "$spam_name [_ dotlrn.Community]"]

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_spam_community -community_id $community_id

set sender_id [ad_conn user_id]
set portal_id [dotlrn_community::get_portal_id -community_id $community_id]

db_1row select_sender_info {}

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
    -value $sender_email

element create spam_message rel_type \
    -label [_ dotlrn.To] \
    -datatype text \
    -widget select \
    -options [list [list [_ dotlrn.Members] dotlrn_member_rel] [list [_ dotlrn.Administrators] dotlrn_admin_rel]] \
    -value $rel_type

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

element create spam_message message_type \
    -label "Message Type" \
    -datatype text \
    -widget select \
    -options {{"Plain text" "text"} {HTML "html"}} \
    -value "text"

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

if {[ns_queryexists "form:confirm"]} {
    form get_values spam_message \
        community_id from rel_type subject message message_type send_date referer

    set segment_id [db_string select_rel_segment_id {}]
    set community_name [dotlrn_community::get_community_name $community_id]
    set community_url "[ad_parameter -package_id [ad_acs_kernel_id] SystemURL][dotlrn_community::get_community_url $community_id]"

    set safe_community_name [db_quote $community_name]

    set query [db_map sender_info]

ns_log notice "query: $query"

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

