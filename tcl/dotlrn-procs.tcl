#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

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

    ad_proc -public community_type {} {
        returns the base community type
    } {
        return "dotlrn_community"
    }

    ad_proc -public class_group_type_key {
    } {
	Returns the group type key used for class groups
    } {
	return [parameter "class_group_type_key"]
    }

    ad_proc -public group_type_key {
    } {
	Returns the group_type key that is being used for class management
    } {
	return [parameter "group_type_key"]
    }

    ad_proc -public package_key {} {
	returns the package key
    } {
	return "dotlrn"
    }

    ad_proc -public get_url {} {
	returns the root URL for dotLRN
    } {
	return "/[package_key]"
    }

    ad_proc -public is_instantiated {} {
	returns 1 if dotlrn is instantiated, 0 otherwise
    } {
        return [ad_decode [apm_num_instances [package_key]] 0 0 1]
    }

    ad_proc -public is_initialized {} {
        is dotlrn initialized with the right community_type?
    } {
        set community_type [community_type]
        return [db_string dotlrn_is_initialized {
            select count(*)
            from dotlrn_community_types
            where community_type = :community_type
            and package_id is not null
        }]
    }

    ad_proc -public init {} {
        create base community_type for dotlrn
    } {
        dotlrn_community::set_type_package_id [community_type] [get_package_id]

        # we need to create a portal for the user workspace and 
        # it's a sin
        dotlrn_community::init \
            -community_type "user_workspace" \
            -community_type_url_part "user-workspace-dummy-url" \
            -pretty_name "User Workspace"


        # do the same for subgroups (dotlrn_community type)
        dotlrn_community::init \
            -community_type "dotlrn_community" \
            -community_type_url_part "subgroups-dummy-url" \
            -pretty_name "Subgroups"
    }

    ad_proc -public is_package_mounted {
        {-package_key:required}
    } {
        returns 1 if package is mounted under dotlrn, 0 otherwise
        FIXME: refactor
    } {
        set package_list [nsv_array get site_nodes "*$package_key*"]
        set dotlrn_ancestor_p 0

        for {set x 1} {$x < [llength $package_list]} {incr x 2} {
            array set package_info [lindex $package_list $x]

            if {[site_node_closest_ancestor_package -default 0 -url $package_info(url) "dotlrn"] != 0} {
                set dotlrn_ancestor_p 1
                break
            }
        }

        return $dotlrn_ancestor_p
    }

    ad_proc -public mount_package {
        {-parent_node_id ""}
        {-package_key:required}
        {-url:required}
        {-directory_p:required}
        {-pretty_name ""}
    } {
        mount a package under dotlrn
    } {
        set parent_node_id [ad_decode $parent_node_id "" [get_node_id] $parent_node_id]

        db_transaction {
            set node_id [db_string get_next_seq_val {
                select acs_object_id_seq.nextval from dual
            }]
            array set parent_node [site_node \
                [site_nodes::get_url_from_node_id -node_id $parent_node_id]
            ]
            set parent_package_id $parent_node(object_id)

            set node_id [site_nodes::site_node_create \
                    -parent_node_id $parent_node_id \
                    -node_id $node_id \
                    -name $url \
                    -directory_p $directory_p]

                if {[empty_string_p $pretty_name]} {
                    set pretty_name $package_key
                }

            set package_id [site_node_create_package_instance $node_id $pretty_name $parent_package_id $package_key]
        }

        return $package_id
    }

    ad_proc -public unmount_package {
        {-package_id:required}
    } {
        unmount a package previously mounted with dotlrn::mount_package.
        just a nice wrapper for the dotrn-*-procs so they don't have to 
        deal with site_nodes and apm directly.
    } {
        db_transaction {
            # site node del package instance
            site_node_delete_package_instance \
                    -package_id $package_id \
                    -node_id [site_nodes::get_node_id_from_package_id \
                                 -package_id $package_id
                             ]
        }
    }

    ad_proc -public unmount_community_applet_package {
        {-community_id:required}
        {-package_key:required}
    } {
        unmount a package from under a community. 
        should be in dotlrn_community::
    } {
        db_transaction {
            set parent_node_id [site_nodes::get_node_id_from_package_id \
                    -package_id [dotlrn_community::get_package_id $community_id]
            ]

            set child_node_id [site_nodes::get_node_id_from_child_name \
                    -parent_node_id $parent_node_id \
                    -name $package_key]

            # site node del package instance
            site_node_delete_package_instance -node_id $child_node_id
        }
    }

    ad_proc -public get_node_id {} {
	return the root node id for dotLRN
    } {
	return [site_node_id [get_url]]
    }

    ad_proc -public get_package_id {} {
	return the package ID for dotLRN
    } {
	array set node [site_node [get_url]]
	return $node(object_id)
    }

    ad_proc -public admin_p {
        {-user_id ""}
    } {
        check if a user is admin for dotLRN
    } {
        return [permission::permission_p -party_id $user_id -object_id [dotlrn::get_package_id] -privilege "admin"]
    }

    ad_proc -public get_users_rel_segment_id {} {
	returns the rel_segment_id of the dotLRN users segment
    } {
	return [db_string select_user_rel_segment {}]
    }

    ad_proc -public get_user_theme {
	user_id
    } {
	Return the user default theme
    } {
	return [util_memoize "dotlrn::get_user_theme_not_cached $user_id"]
    }

    ad_proc -private get_user_theme_not_cached {
	user_id
    } {
	helper
    } {
	return [db_string select_user_theme {} -default ""]
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
        return [util_memoize "dotlrn::get_workspace_portal_id_not_cached $user_id"]
    }

    ad_proc -private get_workspace_portal_id_not_cached {
	user_id
    } {
	Get the workspace page ID for a particular user
    } {
	return [db_string select_user_portal_id {} -default ""]
    }

    ad_proc -public get_user_name {
	user_id
    } {
	Get the names the the user
    } {
        return [util_memoize "dotlrn::get_user_name_not_cached $user_id"]
    }

    ad_proc -private get_user_name_not_cached {
	user_id
    } {
        helper
    } {
	return [db_string select_user_name {
            select first_names || ' ' || last_name
            from cc_users
            where user_id = :user_id
        } -default ""]
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
	set new_node_id [site_node_create $parent_node_id $mount_point]
	set new_package_id [site_node_create_package_instance $new_node_id $package_key $community_id $package_key]

	# Return the newly created package_id
	return $new_package_id
    }
	
    ad_proc -public render_page {
	{-workspace_p ""}
	{-hide_links_p  "f"}
        {-render_style "individual"}
        {-page_num ""}
	portal_id
    } {
	render a page in a user's favorite style
    } {
	return [portal::render \
                -page_num $page_num \
                -hide_links_p $hide_links_p \
                -render_style $render_style \
                $portal_id
        ]
    }

    ad_proc -public get_group_id_from_user_type {
        -type
    } {
        return the group_id of the group that holds users of this type
    } {
        return [db_string select_group_id_from_user_type {} -default ""]
    }

    ad_proc -public get_rel_type_from_user_type {
        -type
    } {
        return the appropriate rel_type base on user type and access level
    } {
        return "dotlrn_${type}_profile_rel"
    }

    ad_proc -public parameter {
        -set
        {-default ""}
        name
    } {
        wrap ad_parameter
    } {
        if {[info exists set]} {
            return [ad_parameter -set -package_id [get_package_id] -default $default $name]
        } else {
            return [ad_parameter -package_id [get_package_id] $name]
        }
    }

}
