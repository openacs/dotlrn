
#
# Procs for DOTLRN basic system
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 18th, 2001
#

ad_library {
    
    Procs for basic dotLRN
    
    @author ben@openforce.net
    @creation-date 2001-08-18
    
}

namespace eval dotlrn {

    ad_proc install {
    } {
	This installs the DOTLRN Class System. There is a lot of stuff that needs to
	be set up to do this correctly, so it must be done at the Tcl Level.

	This proc can be called multiple times, it will do the right thing.

	It will error out in case of impossible to solve issues.
    } {
	
	# If we've already set things up, bail
	set group_type_key [ad_parameter class_group_type_key]
	if {![empty_string_p $group_type_key]} {
	    if {[db_string check_group_type_exist {}] == 1} {
		return
	    }
	}

	# If lower levels, no install
	if {[ad_parameter class_level_p] == 1 || [ad_parameter class_instance_level_p] == 1} {
	    return
	}

	# Make sure we don't call this proc multiple times simultaneously
	## We should really add a critical section here

	# Set up the Class group type
	set group_type_key [group_type::new -group_type "dotlrn_class" "dotLRN Class" "dotLRN Classes"]

	# Store the group_type_key somewhere for future reference
	ad_parameter -set $group_type_key class_group_type_key
	ad_parameter -set 1 dotlrn_level_p
	ad_parameter -set 0 class_level_p
	ad_parameter -set 0 class_instance_level_p

	# Set up the attributes
	set term_attr_id [attribute::add -min_n_values 1 -max_n_values 1 $group_type_key enumeration Term Terms]
	set year_attr_id [attribute::add -min_n_values 1 -max_n_values 1 $group_type_key integer Year Years]
	
	# Add years 2001-2020 as capabilities in system
	for {set year 2001} {$year < 2020} {incr year} {
	    attribute::value_add $year_attr_id $year $year
	}

	# Set up some relationship types and permissible relationships
	
	# Set up some roles
	set roles {
	    {instructor Instructor Instructors}
	    {ta "Teaching Assistant" "Teaching Assistants"}
	    {student Student Students}
	    {admin Administrator Administrators}
	}

	foreach role $roles {
	    set role_key [lindex $role 0]
	    set pretty_name [lindex $role 1]
	    set pretty_plural [lindex $role 2]

	    db_exec_plsql add_role {}
	}

	# The Instructor relationship comes from membership_rel
	rel_types::new -supertype "membership_rel" -role_two instructor \
		instruction_rel Instruction Instructions \
		$group_type_key 0 "" \
		person 0 ""
	
	# The Assistant relationship comes from membership_rel, too
	rel_types::new -supertype "membership_rel" -role_two ta \
		assistance_rel Assistance Assistance \
		$group_type_key 0 "" \
		person 0 ""
	
	# The Student relationship comes from membership_rel, too
	rel_types::new -supertype "membership_rel" -role_two student \
		student_rel Student Students \
		$group_type_key 0 "" \
		person 0 ""
	
	# The Admin relationship, same thing.
	rel_types::new -supertype "membership_rel" -role_two admin \
		administration_rel Administration Administrations \
		$group_type_key 0 "" \
		person 0 ""

	# Add permissible relationships
	rel_types::add_permissible $group_type_key instruction_rel
	rel_types::add_permissible $group_type_key assistance_rel
	rel_types::add_permissible $group_type_key student_rel
	rel_types::add_permissible $group_type_key administration_rel

	# Remove the default permissible rels
	rel_types::remove_permissible $group_type_key membership_rel
	rel_types::remove_permissible $group_type_key composition_rel

    }
	
    ad_proc -public class_group_type_key {
    } {
	Returns the group_type key that is being used for class management
    } {
	return [ad_parameter class_group_type_key]
    }

    ad_proc -public node_id {
	{-package_id ""}
    } {
	Returns the node ID of the current dotLRN package
    } {
	## TOTAL HACK (BEN!!)
	return 0
    }
}
