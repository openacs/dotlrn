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
    Add a members of one community to another

    @author yon (yon@openforce.net)
    @creation-date 2002-02-10
    @param source_community_id The community_id for the source community.  The members of the source community will be added to the target community the user selects.
    @param referer The url for the administration page of the source community.
    @version $Id$
} -query {
    source_community_id:integer
    referer 
} -properties {
    context_bar:onevalue
}


set community_name [db_string select_community_info {}]
set users [dotlrn_community::list_users $source_community_id]

set context_bar [list [list $referer $community_name]  "Add Members to Another Community"]

form create select_community

element create select_community source_community_id \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $source_community_id

element create select_community referer \
        -label "Referer" \
        -datatype text \
        -widget hidden \
        -value $referer

set communities [db_list_of_lists select_all_communities {
    select dotlrn_communities.pretty_name,
           dotlrn_communities.community_id
    from dotlrn_communities
    where dotlrn_communities.portal_id is not NULL
    order by dotlrn_communities.pretty_name,
             dotlrn_communities.community_id
}]

if {[llength $communities]} {
    element create select_community community_id \
        -label "Add users to" \
        -datatype text \
        -widget select \
        -options "{{} {}} $communities"
} else {
    element create select_community community_id \
        -label "No groups to add to" \
        -datatype text \
        -widget hidden \
        -value ""
}

if {[form is_valid select_community]} {
    form get_values select_community \
        source_community_id community_id

    if {![empty_string_p $community_id]} {
        db_transaction {
            foreach user $users {
		set user_id [ns_set get $user user_id]
		if {![dotlrn_community::member_p $community_id $user_id]} {
		    if {[catch {
			# There is still a danger that a double
			# click will cause a failure.
			dotlrn_community::add_user $community_id $user_id
		    } errmsg]} {
			if {[dotlrn_community::member_p $community_id $user_id]} {
			    # assume this was a double click
			    ad_returnredirect $referer
			    ad_script_abort
			} else {
			    ns_log Error "community-members-add-to_community.tcl failed: $errmsg"
			    ReturnHeaders
			    ad_return_error "Error adding user to community"  "An error occured while trying to add a user to a community.  This error has been logged."
			}
		    }
		}
            }
        }
    }

    ad_returnredirect $referer
    ad_script_abort
}


ad_return_template
