
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

    ad_proc -public get_url {} {
	returns the root URL for dotLRN
    } {
	return [apm_package_url_from_key dotlrn]
    }

    ad_proc -public get_node_id {} {
	return the root node id for dotLRN
    } {
	set url [get_url]
	return [site_node_id $url]
    }

    ad_proc -public get_package_id {} {
	return the package ID for dotLRN
    } {
	array set node [site_node [get_url]]
	return $node(object_id)
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
    
    ad_proc -public get_workspace_portal_id {
	user_id
    } {
	Get the workspace page ID for a particular user
    } {
	return [db_string select_user_portal_id {} -default ""]
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
	set package_id [dotlrn_community::get_package_id $community_id]

	# We only take the first node right now
	# FIXME: in case of multi-mounting, which is doubtful, but possible
	# we have a proble here.
	set parent_node_id [db_string select_node_id {}]

	# Mount
	# The context is the community_id
	set new_node_id [site_node_create $parent_node_id $package_key]
	set new_package_id [site_node_create_package_instance $new_node_id $package_key $community_id $package_key]

	# Return the newly created package_id
	return $new_package_id
    }
	
    ad_proc -public render_page {
	{-user_id  ""}
	portal_id
    } {
	render a page in a user's favorite style
    } {
	if {[empty_string_p $user_id]} {
	    set user_id [ad_conn user_id]
	}

	set theme_id [get_user_theme $user_id]

	return [portal::render $portal_id $theme_id]
    }

}
