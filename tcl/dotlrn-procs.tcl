
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
	set group_type_key [ad_parameter group_type_key]
	if {![empty_string_p $group_type_key]} {
	    if {[db_string check_group_type_exist {}] == 1} {
		return
	    }
	}

	# If lower levels, no install
	if {[ad_parameter community_type_level_p] == 1 || [ad_parameter community_level_p] == 1} {
	    return
	}

	# Make sure we don't call this proc multiple times simultaneously
	## We should really add a critical section here

	# Set up the top-level group type
	set group_type_key [group_type::new -group_type "dotlrn_community" "dotLRN Community" "dotLRN Communities"]

	# Store the group_type_key somewhere for future reference
	ad_parameter -set $group_type_key group_type_key
	ad_parameter -set 1 dotlrn_level_p
	ad_parameter -set 0 class_level_p
	ad_parameter -set 0 class_instance_level_p

	# Set up attributes
	set start_date_attr_id [attribute::add -min_n_values 1 -max_n_values 1 $group_type_key date "Start Date" "Start Dates"]
	set end_date_attr_id [attribute::add -min_n_values 1 -max_n_values 1 $group_type_key date "End Date" "End Dates"]

	# Add the general role of administrator
	set role administrator
	set pretty_name Administrator
	set pretty_plural Administrators
	
	db_exec_plsql add_role {}

	# Add the administrator relationship
	rel_types::new -supertype "membership_rel" -role_two administrator \
		administration_rel Administration Administrations \
		$group_type_key 0 "" \
		person 0 ""
	

	# Add permissible relationships
	rel_types::add_permissible $group_type_key administrator_rel
	rel_types::remove_permissible $group_type_key composition_rel

	# Install a few other things
	install_classes $group_type_key
	install_clubs $group_type_key
    }

    ad_proc -private install_classes {
	supertype
    } {
	Install classes
    } {
    }

    ad_proc -private install_clubs {
	supertype
    } {
	Install clubs
    } {

	# Add the group type for classes
	set club_group_type_key [ad_parameter club_group_type_key]
	if {![empty_string_p $club_group_type_key]} {
	    if {[db_string check_group_type_exist {}] == 1} {
		return
	    }
	}

	set club_group_type_key [group_type::new -supertype $supertype -group_type "dotlrn_club" "dotLRN Club" "dotLRN Clubs"]

	# Set parameters
	ad_parameter -set $club_group_type_key club_group_type_key

    }
	
    ad_proc -public group_type_key {
    } {
	Returns the group_type key that is being used for class management
    } {
	return [ad_parameter group_type_key]
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
