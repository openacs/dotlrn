
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
    } {
	create a new community
    } {
	
    }

}
