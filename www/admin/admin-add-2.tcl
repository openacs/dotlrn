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
    Search for a new user for dotLRN

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @author Hector Amado (hr_amado@galileo.edu)
    @creation-date 2004-07-02
    @cvs-id $Id$
} -query {
    user_id
    {referer "dotlrn-admins"}
} -properties {

}


# Get user information
db_1row select_user_info {
    select first_names,
           last_name,
           email
    from dotlrn_users
    where user_id = :user_id
}

# See if the user is already in the dotlrn-admin 
set member_p [group::member_p -group_name "dotlrn-admin" -user_id $user_id ]

set group_id [db_string group_id_from_name "
            select group_id from groups where group_name='dotlrn-admin'" -default ""]

if {!$member_p} {
    if {![empty_string_p $group_id] } {
        group::add_member -group_id $group_id -user_id $user_id
    }
}
            
template::forward dotlrn-admins

