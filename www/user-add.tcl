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

# dotlrn/www/user-add.tcl

ad_page_contract {
    adding a user by an administrator

    @author yon (yon@openforce.net)
    @creation-date 2002-01-19
    @version $Id$
} -query {
    {id ""}
    {type student}
    {can_browse_p 1}
    {read_private_data_p t}
    {add_membership_p t}
    {dotlrn_interactive_p 0}
    {referer members}
} -properties {
    context_bar:onevalue
}

set user_id [ad_maybe_redirect_for_registration]
set community_id [dotlrn_community::get_community_id]

if {![empty_string_p $community_id]} {
    dotlrn::require_user_admin_community -community_id [dotlrn_community::get_community_id]
    set context_bar {{"one-community-admin" Admin} {Add User}}
    set community_p 1
} else {
    dotlrn::require_admin
    set context_bar {{users Users} {Add User}}
    set community_p 0
}

set target_user_id [db_nextval acs_object_id_seq]

form create add_user

element create add_user target_user_id \
    -label "User ID" \
    -datatype integer \
    -widget hidden \
    -value $target_user_id

element create add_user email \
    -label Email \
    -datatype text \
    -widget text \
    -html {size 50} \
    -validate {
        {expr (([util_email_valid_p $value] == 1) && ([util_email_unique_p $value] == 1))}
        {E-mail address must be complete and unique. <br>This user probably already has a SloanSpace account. <br>Try adding this user through <a href=members>Manage Membership</a>.}
    }

element create add_user first_names \
    -label "First Names" \
    -datatype text \
    -widget text \
    -html {size 50}

element create add_user last_name \
    -label "Last Name" \
    -datatype text \
    -widget text \
    -html {size 50}

element create add_user referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

element create add_user type \
    -label Type \
    -datatype text \
    -widget hidden \
    -value $type

element create add_user can_browse_p \
    -label "Access Level" \
    -datatype text \
    -widget hidden \
    -value $can_browse_p

element create add_user read_private_data_p \
    -label "Guest?" \
    -datatype text \
    -widget hidden \
    -value $read_private_data_p

element create add_user add_membership_p \
    -label "Add Membership To Community" \
    -datatype text \
    -widget hidden \
    -value $add_membership_p

element create add_user dotlrn_interactive_p \
    -label "Interactive setting of dotLRN parameters" \
    -datatype text \
    -widget hidden \
    -value $dotlrn_interactive_p

if {[form is_valid add_user]} {
    form get_values add_user \
        target_user_id email first_names last_name referer type can_browse_p read_private_data_p dotlrn_interactive_p

    db_transaction {
        if {[empty_string_p [cc_email_from_party $target_user_id]]} {
            # create the ACS user
            set password [ad_generate_random_string]
            set target_user_id [ad_user_new $email $first_names $last_name $password "" "" "" t approved $target_user_id]
        }

        # can this user read private data?
        acs_privacy::set_user_read_private_data -user_id $target_user_id -object_id [dotlrn::get_package_id] -value $read_private_data_p

        if {!${dotlrn_interactive_p}} {
            # make the user a dotLRN user
            dotlrn::user_add -type $type -can_browse\=$can_browse_p -user_id $target_user_id
        }
    }

    set redirect "user-add-2?[export_vars {{user_id $target_user_id} email password first_names last_name referer}]"
    if {[string equal $add_membership_p t] == 1} {
        set redirect "member-add-2?[export_vars {{user_id $target_user_id} {referer $redirect}}]"
    }

    if {${dotlrn_interactive_p}} {
        set redirect "../${redirect}"
        ad_returnredirect "admin/user-new-2?[export_vars {{user_id $target_user_id} {referer $redirect}}]"
    } else {
        ad_returnredirect $redirect
    }

    ad_script_abort
}

ad_return_template









