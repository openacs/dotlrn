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
    Displays a community

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-04
} -query {
}

# Check that this is a community type
if {[ad_parameter community_level_p] != 1} {
    ns_returnredirect "./"
    return
}

set user_id [ad_conn user_id]

# What community type are we at?
set community_id [dotlrn_community::get_community_id]

# Get basic information
db_1row select_community_info {}

# Check that this user is a member
if {![dotlrn_community::member_p $community_id $user_id]} {
    set context_bar [list "Not a member"]

    set portal_id [dotlrn_community::get_non_member_portal_id -community_id $community_id]

    # Possible that there is no portal page for non-members
    if {![empty_string_p $portal_id]} {
	set rendered_page [dotlrn::render_page $portal_id]
    } else {
	set rendered_page ""
    }

    ad_return_template one-community-not-member
    return
} else {
    set portal_id [dotlrn_community::get_portal_id -community_id $community_id]

    set rendered_page [dotlrn::render_page $portal_id]

    set context_bar {View}

    set admin_p [dotlrn::user_can_admin_community_p $community_id]

    ad_return_template
}
