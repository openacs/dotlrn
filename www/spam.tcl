#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
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

# dotlrn/www/spam.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 19, 2002
    @version $Id$
} -query {
    {community_id ""}
    {rel_type "dotlrn_member_rel"}
    {referer "preferences"}
} -properties {
    context_bar:onevalue
    portal_id:onevalue
}

set context_bar {{$referer Admin} {Spam Community}}

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_admin_community $community_id

set sender_id [ad_conn user_id]
set portal_id [dotlrn_community::get_portal_id $community_id $sender_id]

db_1row select_sender_info {
    select parties.email as sender_email,
           persons.first_names as sender_first_names,
           persons.last_name as sender_last_name
    from parties,
         persons
    where parties.party_id = :sender_id
    and persons.person_id = :sender_id
}

form create spam_message

element create spam_message community_id \
    -label "Community ID" \
    -datatype integer \
    -widget hidden \
    -value $community_id

element create spam_message from \
    -label From \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $sender_email

element create spam_message rel_type \
    -label To \
    -datatype text \
    -widget select \
    -options {{Members dotlrn_member_rel} {Administrators dotlrn_admin_rel}} \
    -value $rel_type

element create spam_message subject \
    -label Subject \
    -datatype text \
    -widget text \
    -html {size 60}

element create spam_message message \
    -label Message \
    -datatype text \
    -widget textarea \
    -html {rows 10 cols 80 wrap soft}

element create spam_message referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid spam_message]} {
    form get_values spam_message \
        community_id from rel_type subject message referer

    # YON: should redirect and close the connection here so that the user
    #      doesn't have to wait for the emails to get sent out.

    set segment_id [db_string select_rel_segment_id {}]
    set community_name [dotlrn_community::get_community_name $community_id]
    set community_url [dotlrn_community::get_community_url $community_id]

    # replace some values in the subject and the message
    set message_values [list]
    lappend message_values [list {<sender_email>} $from]
    lappend message_values [list {<community_name>} $community_name]
    lappend message_values [list {<community_url>} $community_url]

    set recepients [db_list select_recepients {}]

    spam::send \
        -recepients $recepients \
        -from $from \
        -real_from $sender_email \
        -subject $subject \
        -message $message \
        -message_values $message_values

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
