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

    Displays a configuration page for user's portal ONLY!

    Community portals are configured by the one-community-portal-configure
    page.

    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-24
    @version $Id$

}
    
if {[parameter::get -parameter community_type_level_p] == 1} {

    # at a community type level, redirect
    ad_returnredirect "one-community-type"
    return

} elseif {[parameter::get -parameter community_level_p] == 1} {

    # at a community, only admins can configure a comm's portal
    ad_returnredirect "one-community"
    return

} else {

    set user_id [ad_conn user_id]

    # I don't see under what circumstance we wouldn't want users to
    # customize thier own portal. -Caroline.

    #    dotlrn::require_user_browse -user_id $user_id

    # On install, everyone is assigned the default portal
    # If they would like to customize, a new portal will be
    # created for them.

    set portal_id [dotlrn::get_portal_id -user_id $user_id]

    # check if the portal_id is the default_portal_id
 
    set default_portal_p [db_string default_portal_p {
	select count(*) from dotlrn_portal_types_map where portal_id = :portal_id
    }]


    if {$default_portal_p  == 1} {
	# user is set as the default portal
	# give the user their own portal


	set portal_id    [portal::create \
                -template_id $portal_id \
                -name "[_ dotlrn.lt_Your_dotLRN_Workspace]" \
                $user_id]

	db_exec_plsql update_user_portal_id {
	    update dotlrn_user_profile_rels set portal_id = :portal_id 
	    where dotlrn_user_profile_rels.rel_id = 
	    (select rel_id from acs_rels, dotlrn_user_types 
	     where acs_rels.object_id_two = :user_id
	     and acs_rels.object_id_one = dotlrn_user_types.group_id)
	}

	util_memoize_flush "dotlrn::get_portal_id_not_cached -user_id $user_id"
    }

    
    set name [portal::get_name $portal_id]
    set rendered_page [portal::configure -allow_theme_change_p 0 $portal_id "index"]
}

ad_return_template

