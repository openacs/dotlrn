
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

    ad_proc -public class_group_type_key {
    } {
	Returns the group type key used for class groups
    } {
	return [ad_parameter class_group_type_key]
    }

    ad_proc -public group_type_key {
    } {
	Returns the group_type key that is being used for class management
    } {
	return [ad_parameter group_type_key]
    }

    ad_proc -public get_user_theme {
	user_id
    } {
	Return the user default theme
    } {
	return [db_string select_user_theme {}]
    }

    ad_proc -public set_user_theme {
	user_id
	theme_id
    } {
	Set the user theme
    } {
	db_dml update_user_theme {}
    }

    ad_proc -public instantiate_and_mount {
	{-mount_point ""}
	community_id
	package_key
    } {
	Mount an application under a particular community
    } {
	if {[empty_string_p $mount_point]} {
	    set mount_point $package_key
	}

	# Get the parent node_id correctly
	set package_id [dotlrn_community:get_package_id $community_id]

	# We only take the first node right now
	# FIXME: in case of multi-mounting, which is doubtful, but possible
	# we have a proble here.
	set parent_node_id [db_string select_node_id {}]

	# Mount
	set new_package_id [site_node_mount_application -return package_id $parent_node_id $mount_point $package_key $package_key]

	# Return the newly created package_id
	return $new_package_id
    }
	
}
