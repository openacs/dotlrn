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
    register

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-06
    @version $Id$
} -query {
    {user_id ""}
    {community_id ""}
    {referer "./"}
}

ad_maybe_redirect_for_registration

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

if {[empty_string_p $user_id]} {
    set user_id [ad_conn user_id]
} else {
    dotlrn::require_user_admin_community -community_id $community_id
}

set join_policy [db_string select_join_policy {
    select join_policy
    from dotlrn_communities_full
    where community_id = :community_id
}]


# Check to see if the user is member already.
# This should prevent most double clicks, leaving
# the catch below to trap the rest.

if {[dotlrn_community::member_p $community_id $user_id]} {
    ad_returnredirect $referer
    ad_script_abort
}


if {[catch {
    switch -exact $join_policy {
	"open" {
	    dotlrn_community::add_user -member_state approved $community_id $user_id
	}
	"needs approval" {
	    dotlrn_community::add_user -member_state "needs approval" $community_id $user_id
	    
	    # Following the same proccess as spam.tcl to email
	    # admins in bulk.
	    
	    set segment_id [db_string select_admin_rel_segment_id {}]
	    set community_name [dotlrn_community::get_community_name $community_id]
	    set community_url "[ad_parameter -package_id [ad_acs_kernel_id] SystemURL][dotlrn_community::get_community_url $community_id]"
	    
	    set query "select parties.email,
	              decode(acs_objects.object_type,
	              'user',
	               (select first_names
	               from persons
                       where person_id = parties.party_id),
                      'group',
                      (select group_name
                       from groups
                       where group_id = parties.party_id),
                      'rel_segment',
                      (select segment_name
                       from rel_segments
                       where segment_id = parties.party_id),
                      '') as first_names,
               decode(acs_objects.object_type,
                      'user',
                      (select last_name
                       from persons
                       where person_id = parties.party_id),
                      '') as last_name
            from party_approved_member_map,
                 parties,
                 acs_objects
	    where party_approved_member_map.party_id = $segment_id
            and party_approved_member_map.member_id <> $segment_id
            and party_approved_member_map.member_id = parties.party_id
            and parties.party_id = acs_objects.object_id"


	set full_name "[dotlrn::get_user_name $user_id]"
	set email "[cc_email_from_party $user_id]"
	set subject "$full_name ($email) has requested to join $community_name."

	set message "$full_name ($email) has requested to join $community_name.

Visit this link to approve or reject this request:
$community_url/members

        "

	bulk_mail::new \
		-package_id [site_node_apm_integration::get_child_package_id -package_id [dotlrn_community::get_package_id $community_id] -package_key [bulk_mail::package_key]] \
		-from_addr [ad_system_owner] \
		-subject $subject \
		-message $message \
		-query $query

        }
    }
} errmsg]} {

    # Check to see if they are already a member 
    # (in which case this was likely a double click)
        
    if {[dotlrn_community::member_p $community_id $user_id]} {
	ad_returnredirect $referer
	ad_script_abort
    } else {
	ns_log Error "register.tcl failed: $errmsg"
	
	ad_return_error "Error adding user to community"  "An error occured while trying to add a user to a community.  This error has been logged."
    }
}

ad_returnredirect $referer
