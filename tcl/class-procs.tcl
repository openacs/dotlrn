
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
	name
	pretty_name
    } {
	Creates a new class, like "Structure and Interpretation of Computer Programs."
	The return value is the short class name, a key that works in SQL, and that uniquely
	identifies the class.

	This class can then be instantiated for a particular semester.
    } {
	set top_group_type [dotlrn::class_group_type_key]

	set parent_node_id [ad_conn -get node_id]

	set group_type_name "DOTLRN_CLASS_$name"

	db_transaction {
	    # Create a new group type for that class
	    set one_class_group_type_key [group_type::new -group_type $group_type_name -supertype $top_group_type $pretty_name $pretty_name]
	    
	    # Instantiate the DOTLRN Class Manager package at that node
	    set result [site_node_mount_application -return "package_id,node_id" $parent_node_id $name [package_key] $name]
	    set package_id [lindex $result 0]
	    set node_id [lindex $result 1]

	    # Set some parameters
	    ad_parameter -package_id $package_id -set 0 dotlrn_level_p
	    ad_parameter -package_id $package_id -set 1 class_level_p
	    ad_parameter -package_id $package_id -set 0 class_instance_level_p

	    # insert the class into the DB
	    db_dml insert_class {}
	}
    }


    ad_proc -public new_instance {
	class_name
	term
	year
    } {
	Creates a new instance of a class for a particular term and year,
	and returns the class instance key.
    } {
	set parent_node_id [db_string select_parent_node_id {}]
	set class_inst_key "$class_name-$term-$year"

	# Create a group of the right group type
	template::form create add_group
	template::element create add_group group_name -value $class_inst_key
	template::element create add_group term -value $term
	template::element create add_group year -value $year

	set group_id [group::new -form_id add_group $class_name]

	# Instantiate the right package at that site node, probably portals
	set result [site_node_mount_application -return "package_id,node_id" $parent_node_id $class_inst_key [one_class_package_key] $class_inst_key]
	set package_id [lindex $result 0]
	set node_id [lindex $result 1]

	# Set the right parameters
	ad_parameter -package_id $package_id -set 0 dotlrn_level_p
	ad_parameter -package_id $package_id -set 0 class_level_p
	ad_parameter -package_id $package_id -set 1 class_instance_level_p

	# Insert the class instance
	db_dml insert_class_instance {}

	# Assign proper permissions to the site node
	# NOT CERTAIN what to do here yet

    }

    ad_proc -public assign_role {
	class_instance_name
	rel_type
	user_id
    } {
	Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
	# Get the group_id
	set group_id [db_string select_group_id {}]

	# Do the right relationship mapping to assigne the role
	relation_add $rel_type $group_id $user_id
    }
    
    ad_proc -public add_applet {
	class_instance_name
	applet_name
    } {
	Adds an applet for a particular class
    } {
	# Create the site node for that applet

	# Instantiate the right package at the site node
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