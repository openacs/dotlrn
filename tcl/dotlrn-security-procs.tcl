
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
    
    ad_proc -private do_abort {} {
	do an abort if security violation
    } {
	ad_returnredirect "not-allowed"
	return -code error
    }

    ad_proc -public get_user_types {} {
	return the list of possible user types, first type then type_id
    } {
	return [db_list_of_lists select_user_types {}]
    }

    ad_proc -public user_add {
	{-rel_type "dotlrn_user_rel"}
	{-user_id:required}
	{-type_id 1}
    } {
	Add a user as a dotLRN user
    } {
	# set up extra vars
	set extra_vars [ns_set create]
	
	ns_set put $extra_vars user_id $user_id
	ns_set put $extra_vars type_id $type_id

	db_transaction {
	    if {$rel_type == "dotlrn_full_user_rel"} {
		# Create a portal page for this user
		set portal_id [portal::create $user_id]
		
		# Add the basic dotLRN class listing portlet
		dotlrn_main_portlet::add_self_to_page $portal_id {}
		
		# Update the user and set the portal page correctly
		ns_set put $extra_vars portal_id $portal_id
	    }

	    # Add the relation (no need to feed in anything for object_id_one, or two for that matter).
	    set rel_id [relation_add -extra_vars $extra_vars -member_state approved $rel_type "" $user_id]
	}

	return $rel_id
    }

    ad_proc -public user_remove {
	user_id
    } {
	Remove a user from the set of dotLRN users
    } {
	# Get the rel_id and remove it
	set rel_id [db_string select_rel_id {} -default ""]

	if {![empty_string_p $rel_id]} {
	    relation_remove $rel_id
	}
    }

    ad_proc -private user_get_type {
	user_id
    } {
	returns the dotLRN user role or empty string if not a dotLRN user
    } {
	return [db_string select_user_type {} -default ""]
    }

    ad_proc -public user_can_browse_p {
	{user_id ""}
    } {
	Check is a user can browse dotLRN
    } {
	if {[empty_string_p $user_id]} {
	    set user_id [ad_conn user_id]
	}

	# FIXME: must check that a user can browse
	return 1
    }

    ad_proc -public require_user_browse {
	{user_id ""}
    } {
	Require that a user be able to browse dotLRN
    } {
	if {![user_can_browse_p -user_id $user_id]} {
	    do_abort
	}
    }

    ad_proc -public user_can_read_sensitive_data_p {
	{user_id ""}
    } {
	Check if a user can read sensitive data in dotLRN
    } {
	if {[empty_string_p $user_id]} {
	    set user_id [ad_conn user_id]
	}

	# FIXME
	return 1
    }

    ad_proc -public require_user_read_sensitive_data {
	{user_id ""}
    } {
	Require that a user be able to read sensitive data
    } {
	if {![user_can_read_sensitive_data_p -user_id $user_id]} {
	    do_abort
	}
    }

    ad_proc -public user_can_read_community_type_p {
	{-user_id ""}
	community_type
    } {
	Check if a user can read a community type
    } {
	# FIXME: permission hack
	return 1
    }

    ad_proc -public require_user_read_community_type {
	{-user_id ""}
	community_type
    } {
	require that a user be able to read a community type
    } {
	if {![user_can_read_community_type_p -user_id $user_id $community_type]} {
	    do_abort
	}
    }

    ad_proc -public user_can_read_community_p {
	{-user_id ""}
	community_id
    } {
	Check if a user can read a community 
    } {
	return [ad_permission_p -user_id $user_id $community_id dotlrn_view_community]
    }

    ad_proc -public require_user_read_community {
	{-user_id ""}
	community_id
    } {
	require that a user be able to read a community 
    } {
	if {![user_can_read_community_p -user_id $user_id $community_id]} {
	    do_abort
	}
    }

    ad_proc -public user_is_community_member_p {
	{-user_id ""}
	community_id
    } {
	check if a user is a member of a community
    } {
	# FIXME: security hack
	return 1
    }

    ad_proc -public require_user_community_member {
	{-user_id ""}
	community_id
    } {
	require that a user be member of a particular community
    } {
	if {![user_is_community_member_p -user_id $user_id $community_id]} {
	    do_abort
	}
    }
	
    ad_proc -public user_can_admin_community_p {
	{-user_id ""}
	community_id
    } {
	check if a user can admin a community
    } {
	return [ad_permission_p -user_id $user_id $community_id dotlrn_admin_community]
    }

    ad_proc -public require_user_admin_community {
	{-user_id ""}
	community_id
    } {
	require that user be able to admin a community
    } {
	if {![user_can_admin_community_p -user_id $user_id $community_id]} {
	    do_abort
	}
    }

}
