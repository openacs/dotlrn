
#
# Procs for DOTLRN Community Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# September 28th, 2001
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
	# Exec the statement, easy
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
    
    ad_proc set_attribute {
	community_id
	attribute_name
	attribuate_value
    } {
	Set an attribute for a community
    } {
	# Not sure what to do here yet
    }

    ad_proc -public list_users {
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
	community_id
	rel_type
	user_id
    } {
	Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
	db_transaction {
	    # Set up the relationship
	    set rel_id [relation_add -member_state approved $rel_type $community_id $user_id]
	    
	    # Set up a portal page for that user
	    set page_id [portal::create $user_id]
	    
	    # Insert the membership
	    db_dml insert_membership {}
	    
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
	    
	    # Remove the membership
	    db_dml delete_membership {}
	    
	    # Remove the page
	    portal::delete $page_id
	    
	    # Remove it
	    relation_remove $rel_id
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

    ad_proc -public get_all_communities_by_user {
	user_id
    } {
	returns all communities for a user
    } {
	set list_of_communities [list]
	### HACK HERE !!! (ben)
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
