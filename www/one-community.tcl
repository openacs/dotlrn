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
    @author yon (yon@openforce.net)
    @creation-date 2001-10-04
    @version $Id$
} -query {
    {page_num 0}
}

# Check that this is a community type
if {[parameter::get -parameter community_level_p] != 1} {
    ns_returnredirect "./"
    ad_script_abort
}

# Get basic information
set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]
set pretty_name [dotlrn_community::get_community_name $community_id]
set admin_p [dotlrn::user_can_admin_community_p \
        -user_id $user_id \
        $community_id
]

# are we in a subcomm? if so, we need to set up the text and navbar 
set pretext ""
set parent_id [dotlrn_community::get_parent_id \
        -community_id $community_id]

if {![empty_string_p $parent_id]} {
    set parent_name [dotlrn_community::get_community_name $parent_id]
    set pretext "<a href=..>$parent_name</a> : "
} 

# Check that this user is a member
if {![dotlrn_community::member_p $community_id $user_id] && !$admin_p} {
    set context_bar [list "Not a member"]

    if {[dotlrn_community::member_pending_p -community_id $community_id -user_id $user_id]} {
        set member_pending_p "t"
        set context_bar [list "Pending approval"]
    }

    set portal_id [dotlrn_community::get_non_member_portal_id -community_id $community_id]

    # Possible that there is no portal page for non-members
    if {! [empty_string_p $portal_id]} {
	set rendered_page [dotlrn::render_page -hide_links_p "t" -page_num $page_num $portal_id]
        
    } else {
	set rendered_page ""
    }

    ad_return_template one-community-not-member
    return
} else {
    set portal_id [dotlrn_community::get_portal_id -community_id $community_id]

    set rendered_page [dotlrn::render_page -hide_links_p "t" -page_num $page_num $portal_id]

    set context_bar {View}
    set url_stub "one-community"

    ad_return_template 
}
