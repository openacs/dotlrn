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
    Displays single dotLRN community page for admin

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-27
    @version $Id$
} -query {
} -properties {
    community_id:onevalue
    community_type:onevalue
    pretty_name:onevalue
    description:onevalue
    portal_id:onevalue
    admin_portal_id:onevalue
    non_member_portal_id:onevalue
    users:multirow
}

# Used to keep track of navigation links
 ad_set_client_property dotlrn page_num "-1"

set community_id [dotlrn_community::get_community_id]
set user_id [ad_get_user_id]

# Permissions
dotlrn::require_user_admin_community -user_id $user_id -community_id $community_id

db_1row select_community_info {}

# render the admin page
set rendered_page [dotlrn::render_page -render_style all_in_one $admin_portal_id]

set context [list [_ dotlrn.control_panel]]
