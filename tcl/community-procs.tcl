
#
# Procs for DOTLRN Community Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# September 28th, 2001
# ben@openforce.net
#

ad_library {
    
    Procs to manage DOTLRN Communities
    
    @author ben@openforce.net
    @creation-date 2001-09-28
    
}

namespace eval dotlrn_community {

    ad_proc -public new_type {
	{-description ""}
	community_type
	supertype
	pretty_name
    } {
	Create a new community type.
    } {
	# Insert the community type
	db_exec_plsql create_community_type {}
    }
    
    ad_proc set_type_package_id {
	community_type
	package_id
    } {
	Update the package ID for the community type
    } {
	# Exec the statement, easy
	db_dml update_package_id {}
    }
    
    ad_proc -public new {
	{-description ""}
	community_type
	name
	pretty_name
    } {
	create a new community
    } {
	# Create the community
	set community_id [db_exec_plsql create_community {}]

	return $community_id
    }

    ad_proc set_package_id {
	community_id
	package_id
    } {
	Update the node ID for the community
    } {
	db_dml update_package_id {}
    }
    
    ad_proc admin_access_p {
	community_id
    } {
	Checks admin access to a community
    } {
	# HACK FOR NOW!! (ben) FIXIT
	return 1
    }
    
    ad_proc -public get_url {
	{-current_node_id ""}
	{-package_id ""}
    } {
	This gets the relative URL for a package_id under a particular node_id
    } {
	if {[empty_string_p $current_node_id]} {
	    set current_node_id [site_node_id [ad_conn url]]
	}

	return [db_string select_node_url {} -default ""]
    }

    ad_proc -public get_url_from_package_id {
	{-package_id ""}
    } {
	This gets the relative URL for a package_id.
    } {
	return [db_string select_node_url {} -default ""]
    }
    
    ad_proc set_attribute {
	community_id
	attribute_name
	attribute_value
    } {
	Set an attribute for a community
    } {
	# Not sure what to do here yet
    }

    ad_proc -public get_allowed_rel_types {
	{ -community_type "" }
	{ -community_id "" }
    } {
	if {[empty_string_p $community_type]} {
	    set community_type [get_community_type_from_community_id $community_id]
	}
	
	if {$community_type == "dotlrn_class"} {
	    return {
		{dotlrn_student_rel Student}
		{dotlrn_ta_rel TA}
		{dotlrn_instructor_rel Instructor}
		{dotlrn_admin_rel Admin}
	    }
	}

	if {$community_type == "dotlrn_club"} {
	    return {
		{dotlrn_member_rel Member}
		{dotlrn_admin_rel Admin}
	    }
	}

	return {}
    }


    ad_proc -public get_pretty_rel_type {
	rel_type
    } {
	Returns a pretty version of the rel_type
    } {
	set pretty_name [db_string select_pretty_name "select pretty_name from acs_object_types where object_type=:rel_type"]
	return $pretty_name
    }

    ad_proc -public list_admin_users {
	community_id
    } {
	Returns list of admin users
    } {
	return [list_users -rel_type "dotlrn_admin_rel" $community_id]
    }
    
    ad_proc -public list_users {
	{-rel_type "dotlrn_member_rel"}
	community_id
    } {
	Returns the list of users with a membership_id, a user_id, first name, last name, email, and role
    } {
	return [db_list_of_lists select_users {}]
    }
    
    ad_proc -public member_p {
	community_id
	user_id
    } {
	check membership
    } {
	return [db_string select_count_membership {}]
    }
    
    ad_proc -public add_user {
	{-rel_type "dotlrn_member_rel"}
	community_id
	user_id
    } {
	Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
	db_transaction {
	    # Set up a portal page for that user and that community
	    set page_id [portal::create $user_id]
	    
	    # Create the form with the page_id
	    set extra_vars [ns_set create]
	    ns_set put $extra_vars page_id $page_id
	    ns_set put $extra_vars user_id $user_id
	    ns_set put $extra_vars community_id $community_id
	    ns_set put $extra_vars class_instance_id $community_id

	    # Set up the relationship
	    set rel_id [relation_add -extra_vars $extra_vars -member_state approved $rel_type $community_id $user_id]
	    
	    # do the callbacks
	    applets_dispatch $community_id AddUser [list $community_id $user_id]
	}
    }

    ad_proc -public remove_user {
	community_id
	user_id
    } {
	Removes a user from a class
    } {
	db_transaction {
	    # Callbacks
	    applets_dispatch $community_id RemoveUser [list $community_id $user_id]
	    
	    # Get a few important things, like rel_id and portal page_id
	    db_1row select_rel_info {}

	    # Remove it
	    relation_remove $rel_id

	    # Remove the page
	    portal::delete $page_id
	}
    }
    
    ad_proc -public get_page_id {
	community_id
	user_id
    } {
	Get the page ID for a particular community and user
    } {
	return [db_string select_page_id {}]
    }

    ad_proc -public get_workspace_page_id {
	user_id
    } {
	Get the workspace page ID for a particular user
    } {
	return [db_string select_user_page_id {}]
    }

    ad_proc -public get_community_non_members_page_id {
	community_id
    } {
	Get the community page ID for non-members
    } {
	return [db_string select_community_page_id {}]
    }

    ad_proc -public get_all_communities_by_user {
	user_id
    } {
	returns all communities for a user
    } {
	set return_list [db_list_of_lists select_communities_by_user {}]

	ns_log Notice "return list: $return_list"

	return $return_list
    }

    ad_proc -public get_communities_by_user {
	community_type
	user_id
    } {
	Return a datasource of the communities that a user belongs to in a particular type
    } {
	set list_of_communities [list]

	db_foreach select_communities {} {
	    lappend list_of_communities [list $community_id $community_type $pretty_name $description [get_url -package_id $package_id]]
	}
	
	return $list_of_communities
    }
    
    ad_proc -public get_active_communities {
	community_type
    } {
	Returns a list of active communities for a given type.
	FIXME: right now all communities are active.
    } {
	set list_of_communities [list]

	db_foreach select_active_communities {} {
	    lappend list_of_communities [list $community_id $community_type $pretty_name $description [get_url -package_id $package_id]]
	}

	return $list_of_communities
    }

    ad_proc -public get_all_communities {
	community_type
    } {
	Returns a list of all communities, and whether or not they are active.
    } {
	return [db_list_of_lists select_all_communities {}]
    }

    ad_proc -public get_toplevel_community_type_from_community_id {
	community_id
    } {
	returns the community type from community_id
    } {
	return [db_string select_community_type {}]
    }

    ad_proc -public get_community_type_from_community_id {
	community_id
    } {
	returns the community type from community_id
    } {
	return [db_string select_community_type {}]
    }

    ad_proc -public get_community_type {
    } {
	Returns the community type key depending on the node we're at
    } {
	set package_id [ad_conn package_id]

	return [db_string select_community_type {} -default ""]
    }

    ad_proc -public get_community_id {
    } {
	Returns the community id depending on the node we're at
    } {
	set package_id [ad_conn package_id]

	return [db_string select_community {} -default ""]
    }

    ad_proc -public get_community_type_url {
	community_type
    } {
	Get the URL for a community type
    } {
	return [get_url_from_package_id -package_id [get_community_type_package_id $community_type]]
    }

    ad_proc -public get_community_url {
	community_id
    } {
	Get the URL for a community
    } {
	return [get_url_from_package_id -package_id [get_package_id $community_id]]
    }

    ad_proc -public get_community_type_package_id {
	community_type
    } {
	get the package id for a particular community type
    } {
	return [db_string select_package_id {} -default ""]
    }

    ad_proc -public get_package_id {
	community_id
    } {
	get the package ID for a particular community
    } {
	return [db_string select_package_id {} -default ""]
    }

    ad_proc -public get_applet_package_id {
	community_id
	applet_key
    } {
	get the package ID for a particular community
    } {
	return [db_string select_package_id {} -default ""]
    }

    ad_proc -public get_community_type_name {
	community_type
    } {
	get the name for a community type
    } {
	return [db_string select_community_type_name {} -default ""]
    }

    ad_proc -public get_community_name {
	community_id
    } {
	get the name for a community
    } {
	return [db_string select_community_name {} -default ""]
    }
    
    ad_proc -public add_applet {
	community_id
	applet_key
    } {
	Adds an applet to the community
    } {
	db_transaction {
	    # Callback
	    set package_id [applet_call $applet_key AddApplet [list $community_id]]

	    # Insert in the DB
	    db_dml insert_applet {}	    

	    # Go through current users and make sure they are added!
	    foreach user [list_users $community_id] {
		set user_id [lindex $user 2]

		# do the callbacks
		applet_call $applet_key AddUser [list $community_id $user_id]
	    }
	}
    }

    ad_proc -public remove_applet {
	community_id
	applet_key
    } {
	Removes an applet from a community
    } {
	# Get the package_id
	set package_id [get_package_id $community_id]

	db_transaction {
	    # Take care of all existing users
	    foreach user [list_users $community_id] {
		set user_id [lindex $user 2]

		# do the callbacks
		applet_call $applet_key RemoveUser [list $community_id $user_id]
	    }
	    
	    # Callback
	    applet_call $applet_key RemoveApplet [list $community_id $package_id]
	    
	    # Delete from the DB
	    db_dml delete_applet {}
	}
    }

    ad_proc -public list_applets {
	{community_id ""}
    } {
	Lists the applets associated with a community
    } {
	if {[empty_string_p $community_id]} {
	    # List all applets
	    return [db_list select_all_applets {}]
	} else {
	    # List from the DB
	    return [db_list select_community_applets {}]
	}
    }

    ad_proc -public applets_dispatch {
	community_id
	op
	list_args
    } {
	Dispatch an operation to every applet
    } {
	foreach applet [list_applets $community_id] {
	    # Callback on applet
	    applet_call $applet $op $list_args
	}
    }

    ad_proc -public applet_call {
	applet_key
	op
	{list_args {}}
    } {
	Call a particular applet op
    } {
	acs_sc_call dotlrn_applet $op $list_args $applet_key
    }

}
