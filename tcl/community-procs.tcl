
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

    ad_proc new_type {
	community_type
	supertype
	pretty_name
	{-description ""}
    } {
	Create a new community type.
    } {
	# Create the group type
	set group_type_key [group_type::new -group_type $community_type -supertype $parent_type $pretty_name $pretty_name]

	# Insert the community type
	db_dml insert_community_type {}
    }

    ad_proc set_type_site_node {
	community_type
	node_id
    } {
	Update the node ID for the community type
    } {
	# Exec the statement, easy
	db_dml update_site_node {}
    }

    ad_proc new {
	community_type
	name
	pretty_name
	{-description ""}
    } {
	create a new community
    } {
	# Create the group
	set community_id [group::new -group_name $name $community_type]

	# insert the community row
	db_dml insert_community {}

	return $community_id
    }

    ad_proc set_site_node {
	community_id
	node_id
    } {
	Update the node ID for the community
    } {
	# Exec the statement, easy
	db_dml update_site_node {}
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

    ad_proc -public add_user {
	community_id
	rel_type
	user_id
    } {
	Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
	# Set up the relationship
	set rel_id [relation_add $rel_type $community_id $user_id]

	# Set up a portal page for that user
	# NPP call
	set page_id []

	# Insert the membership
	db_dml insert_membership {}

	# do the callbacks
	applets_dispatch AddUser [list $community_id $user_id]
    }

    ad_proc -public remove_user {
	community_id
	user_id
    } {
	Removes a user from a class
    } {
	# Callbacks
	applets_dispatch RemoveUser [list $community_id $user_id]

	# Get the relationship ID
	set rel_id [db_string select_rel_id {}]

	# Remove the membership
	db_dml delete_membership {}

	# Remove it
	relation_remove $rel_id
    }
    
    ad_proc -public get_page_id {
	community_id
	user_id
    } {
	Get the page ID for a particular community and user
    } {
	return [db_string select_page_id {}]
    }

    ad_proc -public add_applet {
	community_id
	applet_key
    } {
	Adds an applet to the community
    } {
	# Insert in the DB
	db_dml insert_applet {}
    }

    ad_proc -public remove_applet {
	community_id
	applet_key
    } {
	Removes an applet from a community
    } {
	# Delete from the DB
	db_dml delete_applet {}
    }

    ad_proc -public list_applets {
	community_id
    } {
	Lists the applets associated with a community
    } {
	# List from the DB
	return [db_list select_community_applets {}]
    }

    ad_proc -public applets_dispatch {
	op
	list_args
    } {
	Dispatch an operation to every applet
    } {
	foreach applet [list_applets] {
	    # Callback on applet
	    acs_sc_call dotLRN_Applet $op $list_args $applet
	}
    }

}
