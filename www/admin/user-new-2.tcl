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
    Create a dotLRN user

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    user_id
    {referer "[dotlrn::get_admin_url]/users"}
}


set context_bar {{users Users} {New}}

db_1row select_user_info {
    select email,
           first_names,
           last_name
    from registered_users
    where user_id = :user_id
}

form create add_user

element create add_user user_id \
    -label "User ID" \
    -datatype integer \
    -widget hidden \
    -value $user_id

element create add_user id \
    -label ID \
    -datatype text \
    -widget text \
    -html {size 30} \
    -value $email \
    -optional

element create add_user type \
    -label "User Type" \
    -datatype text \
    -widget select \
    -options [dotlrn::get_user_types_as_options]

element create add_user access_level \
    -label "Access Level" \
    -datatype text \
    -widget select \
    -options {{"Full Access" full} {"Limited Access" limited}}

element create add_user read_private_data_p \
    -label "Guest?" \
    -datatype text \
    -widget select \
    -options {{No t} {Yes f}}

element create add_user referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_user]} {
    form get_values add_user \
        user_id id type access_level read_private_data_p referer

    db_transaction {
        dotlrn::user_add -id $id -type $type -access_level $access_level -user_id $user_id
        acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] -value $read_private_data_p
    }

    ad_returnredirect $referer
    # I don't think a script abort is the right thing (ben)
    # ad_script_abort
    return
}

set context_bar {{users Users} New}

ad_return_template
