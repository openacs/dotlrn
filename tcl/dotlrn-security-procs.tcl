
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
	    # NOT IMPLEMENTED YET!

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

    ad_proc -public guest_add {
	community_id
	user_id
    } {
	Add a guest to a particular community
    } {
	db_dml add_guest {}
    }

    ad_proc -public guest_remove {
	community_id
	user_id
    } {
	Remove a guest from a particular community
    } {
	db_dml remove_guest {}
    }

    ad_proc -public user_can_browse_p {
	{user_id ""}
    } {
	Check is a user can browse dotLRN
    } {
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
