
#
# Procs for DOTLRN Class Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 18th, 2001
#

ad_library {
    
    Procs to manage DOTLRN Classes
    
    @author ben@openforce.net
    @creation-date 2001-08-18
    
}

namespace eval dotlrn_class {

    ad_proc -public new {
	{-description ""}
	name
	pretty_name
    } {
	Creates a new class, like "Structure and Interpretation of Computer Programs."
	The return value is the short class name, a key that works in SQL, and that uniquely
	identifies the class.

	This class can then be instantiated for a particular semester.
    } {
	set parent_node_id [ad_conn -get node_id]

	set group_type_name "dotlrn_class_$name"

	db_transaction {
	    # Create the class directly using PL/SQL API
	    set class_group_type_key [db_exec_plsql create_class {}]

	    # Create a new group type for that class
	    # OLD STUFF (not relevant with PL/SQL API)
	    # set class_group_type_key [group_type::new -group_type $group_type_name -supertype $top_group_type $pretty_name $pretty_name]
	    
	    # Instantiate the DOTLRN Class Manager package at that node
	    set result [site_node_mount_application -return "package_id,node_id" $parent_node_id $name [package_key] $name]
	    set package_id [lindex $result 0]
	    set node_id [lindex $result 1]

	    # Set some parameters
	    ad_parameter -package_id $package_id -set 0 dotlrn_level_p
	    ad_parameter -package_id $package_id -set 1 community_type_level_p
	    ad_parameter -package_id $package_id -set 0 community_level_p

	    # Old stuff
	    # dotlrn_community::new_type $class_group_type_key dotlrn_class $pretty_name

	    # Set the site node
	    dotlrn_community::set_type_site_node $class_group_type_key $node_id

	    # insert the class into the DB
	    # ALREADY DONE by PL/SQL API
	    # db_dml insert_class {}
	}

	return $class_group_type_key
    }


    ad_proc -public new_instance {
	class_type
	class_name
	term
	year
    } {
	Creates a new instance of a class for a particular term and year,
	and returns the class instance key.
    } {
	set short_name "$class_type-$term-$year"

	# Create the community
	set community_id [dotlrn_community::new dotlrn_class $short_name $pretty_name]

	# Insert the class instance
	db_dml insert_class_instance {}

	# Set up the node
	set parent_node_id [db_string select_parent_node_id {}]

	# Instantiate the right package at that site node, probably portals
	set result [site_node_mount_application -return "package_id,node_id" $parent_node_id $short_name [one_class_package_key] $short_name]
	set package_id [lindex $result 0]
	set node_id [lindex $result 1]

	# Set the right parameters
	ad_parameter -package_id $package_id -set 0 dotlrn_level_p
	ad_parameter -package_id $package_id -set 0 class_level_p
	ad_parameter -package_id $package_id -set 1 class_instance_level_p

	# Set up the node
	dotlrn_community::set_site_node $community_id $node_id

	# Assign proper permissions to the site node
	# NOT CERTAIN what to do here yet

    }

    ad_proc -public available_roles {
    } {
	Returns the available roles
    } {
	return {
	    {instructor_rel "Instructor"}
	    {ta_rel "Teaching Assistant"}
	    {student_rel "Student"}
	    {admin_rel "Administrator"}
	}
    }

    ad_proc -public package_key {
    } {
	Returns the package key for this package
    } {
	return "dotlrn"
    }

    ad_proc -public one_class_package_key {
    } {
	Returns the package key for this package
    } {
	return "dotlrn"
    }

}
