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
    Search for a new user for dotLRN

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    user_id
    {referer "one-community-admin"}
} -properties {
    roles:multirow
}

set community_id [dotlrn_community::get_community_id]

dotlrn::require_user_admin_community $community_id

# Get user information
db_1row select_user_info {
    select first_names,
           last_name,
           email
    from dotlrn_users
    where user_id = :user_id
}

# Depending on the community_type, we have allowable rel_types
set rel_types [dotlrn_community::get_roles -community_id $community_id]

template::multirow create roles rel_type pretty_name

foreach role $rel_types {
    template::multirow append roles [lindex $role 0] [lindex $role 2]
}

ad_return_template
