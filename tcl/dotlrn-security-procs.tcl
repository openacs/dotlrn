
#
# Procs for dotLRN Security
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# October 30th, 2001
# ben@openforce.net
#

ad_library {
    
    Procs to manage DOTLRN Security
    
    @author ben@openforce.net
    @creation-date 2001-10-30
    
}

namespace eval dotlrn {
    
    ad_proc -public user_add {
	{-role "user"}
	user_id	
    } {
	Add a user as a dotLRN user
    } {
	db_transaction {
	    db_exec_plsql add_user {}

	    # Create a portal page for this user
	    set page_id [portal::create $user_id]

	    # Add the basic dotLRN class listing portlet
	    dotlrn_main_portlet::add_self_to_page $page_id {}

	    # Update the user and set the portal page correctly
	    db_dml update_user_page_id {}
	}
    }

    ad_proc -public user_remove {
	user_id
    } {
	Remove a user from the set of dotLRN users
    } {
	db_dml remove_user {}
    }

    ad_proc -private user_get_role {
	user_id
    } {
	returns the dotLRN user role or empty string if not a dotLRN user
    } {
	return [db_string select_user_role {} -default ""]
    }

    ad_proc -public guest_add {
	community_id
	user_id
    } {
	Add a guest to a particular community
    } {
	db_transaction {
	    # Check if this user is a user already
	    if {[empty_string_p [user_get_role $user_id]]} {
		# Add the user as a guest
		user_add -role guest $user_id
	    }

	    # Subscribe the guest to that community
	    dotlrn_community::add_user $community_id $user_id
	}
    }

    ad_proc -public guest_remove {
	community_id
	user_id
    } {
	Remove a guest from a particular community
    } {
	dotlrn_community::remove_user $community_id $user_id
    }

    ad_proc -public user_can_browse_p {
	{user_id ""}
    } {
	Check is a user can browse dotLRN
    } {
	if {[empty_string_p $user_id]} {
	    set user_id [ad_conn user_id]
	}

	if {[user_get_role $user_id] == "guest"} {
	    return 0
	} else {
	    return 1
	}
    }

    ad_proc -public require_user_browse {
	{user_id ""}
    } {
	Require that a user be able to browse dotLRN
    } {

    }

    ad_proc -public user_can_read_sensitive_data_p {
	{user_id ""}
    } {
	Check if a user can read sensitive data in dotLRN
    } {
	if {[empty_string_p $user_id]} {
	    set user_id [ad_conn user_id]
	}

	if {[user_get_role $user_id] == "guest"} {
	    return 0
	} else {
	    return 1
	}
    }

    ad_proc -public require_user_read_sensitive_data {
	{user_id ""}
    } {
	Require that a user be able to read sensitive data
    } {
    }

    ad_proc -public user_can_read_community_type_p {
	{-user_id ""}
	community_type
    } {
	Check if a user can read a community type
    } {
    }

    ad_proc -public require_user_read_community_type {
	{-user_id ""}
	community_type
    } {
	require that a user be able to read a community type
    } {
    }

    ad_proc -public user_can_read_community_p {
	{-user_id ""}
	community_id
    } {
	Check if a user can read a community 
    } {
    }

    ad_proc -public require_user_read_community {
	{-user_id ""}
	community_id
    } {
	require that a user be able to read a community 
    } {
    }

    ad_proc -public user_is_community_member_p {
	{-user_id ""}
	community_id
    } {
	check if a user is a member of a community
    } {
    }

    ad_proc -public require_user_community_member {
	{-user_id ""}
	community_id
    } {
	require that a user be member of a particular community
    } {
    }
	
    ad_proc -public user_can_admin_community_p {
	{-user_id ""}
	community_id
    } {
	check if a user can admin a community
    } {
    }

    ad_proc -public require_user_admin_community {
	{-user_id ""}
	community_id
    } {
	require that user be able to admin a community
    } {
    }

}
