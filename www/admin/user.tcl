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
    One user view by a dotLRN admin
    
    @author yon (yon@openforce.net)
    @creation-date 2002-03-13
    @version $Id$
} {
    user_id:integer,notnull
} -properties {
    context_bar:onevalue
    first_names:onevalue
    last_name:onevalue
    email:onevalue
    screen_name:onevalue
    user_id:onevalue
    registration_date:onevalue
    last_visit:onevalue
    export_edit_vars:onevalue
    portrait_p:onevalue
    portrait_title:onevalue
    change_state_links:onevalue
    return_url:onevalue
    dotlrn_user_p:onevalue
    member_classes:multirow
    member_clubs:multirow
}

set oacs_site_wide_admin_p [acs_user::site_wide_admin_p]

set return_url "[ad_parameter -package_id [ad_acs_kernel_id] CommunityMemberAdminURL]?user_id=$user_id"
set export_edit_vars "user_id=$user_id&return_url=$return_url"

set dotlrn_url [dotlrn::get_url]
set root_object_id [acs_magic_object security_context_root]
if {![db_0or1row select_user_info {}]} {
    ad_return_complaint 1 "<li>[_ dotlrn.couldnt_find_user_id [list user_id $user_id]]</li>"
    ad_script_abort
}
if {[empty_string_p $screen_name]} {
    set screen_name "&lt;[_ dotlrn.none_set_up]&gt;"
}
set registration_date [lc_time_fmt $registration_date "%q"]
if {![empty_string_p $last_visit]} {
    set last_visit [lc_time_fmt $last_visit "%q"]
}

set dotlrn_package_id [dotlrn::get_package_id]
set dotlrn_user_p 0
if {[db_0or1row select_dotlrn_user_info {}]} {
    set dotlrn_user_p 1
}
set can_browse_p [dotlrn::user_can_browse_p -user_id $user_id]

set portrait_p 0
if {[ad_parameter "show_portrait_p" dotlrn] && [db_0or1row select_portrait_info {}]} {
    set portrait_p 1
}

set change_state_links "\[<small>[join [ad_registration_finite_state_machine_admin_links $member_state $email_verified_p $user_id $return_url] " | "]</small>\]"

db_multirow member_classes select_member_classes {} {
    set role_pretty_name [dotlrn_community::get_role_pretty_name -community_id $class_instance_id -rel_type $rel_type]
}
db_multirow member_clubs select_member_clubs {} {
    set role_pretty_name [dotlrn_community::get_role_pretty_name -community_id $club_id -rel_type $rel_type]
}
db_multirow member_subgroups select_member_subgroups {} {
    set role_pretty_name [dotlrn_community::get_role_pretty_name -community_id $community_id -rel_type $rel_type]
}

set site_wide_admin_p [permission::permission_p \
        -party_id $user_id \
        -object_id [acs_magic_object "security_context_root"] \
        -privilege admin \
        ]

set context_bar [list [list users [_ dotlrn.Users]] "$first_names $last_name"]

set dual_approve_return_url [ns_urlencode [dotlrn::get_admin_url]/user-new-2?user_id=$user_id&referer=$return_url]

set approve_user_url "/acs-admin/users/member-state-change?user_id=$user_id&member_state=approved&return_url=$dual_approve_return_url"

set remove_user_url "\[<small><a href=\"[export_vars -base user-nuke {user_id}]\">Nuke</a></small>\]"

# Used in some en_US messages in the adp file
set class_instances_pretty_name [parameter::get -localize -parameter class_instances_pretty_name]
set clubs_pretty_name [parameter::get -localize -parameter clubs_pretty_name]
set subcommunities_pretty_name [parameter::get -localize -parameter subcommunities_pretty_name]

set dual_approve_return_url [ns_urlencode [dotlrn::get_admin_url]/user-new-2?user_id=$user_id&referer=$return_url]

ad_return_template
