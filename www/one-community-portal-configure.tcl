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

    Displays a configuration page for COMMUNITY'S portal ONLY!
    This page is restricted to admins of the community.

    User portals are configured by the configure.tcl page.

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
    {referer "one-community-admin"}
}

set community_id [dotlrn_community::get_community_id]

dotlrn::require_user_admin_community \
    -user_id [ad_conn user_id] \
    -community_id $community_id

set portal_id  [dotlrn_community::get_portal_id] 

# we are in a community
set community_name [dotlrn_community::get_community_name $community_id]

set default_portal_p [db_string default_portal_p {
    select count(*) from dotlrn_portal_types_map where portal_id = :portal_id
}]


if {$default_portal_p == 1} {
    # Create comm's portal page
    set portal_id [portal::create \
		       -template_id $portal_id \
		       -name "$community_name Portal" \
		       -context_id $community_id \
		       [ad_conn user_id] \
		      ]
    
    db_exec_plsql update_commuity_portal_id {
	update dotlrn_communities_all 
	set portal_id = :portal_id
	where community_id = :community_id
    }
    
    util_memoize_flush "dotlrn_community::get_portal_id_not_cached -community_id $community_id"    
}


set rendered_page [portal::configure \
    -allow_theme_change_p 0 \
    [dotlrn_community::get_portal_id] \
    $referer
]

ad_return_template

