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

ad_page_contract {
    Edit a dotLRN user

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-12-10
    @version $Id$
} -query {
    {return_url "/dotlrn/admin/users"}
    user_id
}

set context_bar {{users Users} {Edit}}
set dotlrn_package_id [dotlrn::get_package_id]

db_1row select_user_info {}

form create edit_user

element create edit_user user_id \
    -label "User ID" \
    -datatype integer \
    -widget hidden \
    -value $user_id

element create edit_user id \
    -label "ID" \
    -datatype text \
    -widget text \
    -html {size 30} \
    -value $id \
    -optional

element create edit_user type \
    -label "User Type" \
    -datatype text \
    -widget select \
    -options [dotlrn::get_user_types_as_options] \
    -value $type

element create edit_user access_level \
    -label "Access Level" \
    -datatype text \
    -widget select \
    -options {{"Full Access" "full"} {"Limited Access" "limited"}} \
    -value $access_level

element create edit_user read_private_data_p \
    -label "Guest?" \
    -datatype text \
    -widget select \
    -options {{"No" "t"} {"Yes" "f"}} \
    -value $read_private_data_p

element create edit_user return_url \
    -label "Return URL" \
    -datatype text \
    -widget hidden \
    -value $return_url

if {[form is_valid edit_user]} {
    form get_values edit_user \
        user_id id type access_level read_private_data_p return_url

    db_transaction {
        # remove the user
        dotlrn::user_remove -user_id $user_id

        # add the user
        dotlrn::user_add \
            -id $id \
            -type $type \
            -access_level $access_level \
            -user_id $user_id

        # Update permissions
        acs_privacy::set_user_read_private_data \
            -user_id $user_id \
            -object_id [dotlrn::get_package_id] \
            -value $read_private_data_p
    }

    # redirect
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
