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

    ad_proc -public is_instantiated_here {
        {-url:required}
        {-package_key ""}
    } {
        returns 1 if dotlrn is instantiaed under the url specified, 0
        otherwise

        XXX - aks -  I think there a bug in here somewhere - use the
        procs in  site_nodes:: instead. Thanks.
    } {
        set result 0

        if {[empty_string_p $package_key]} {
            set package_key [dotlrn::package_key]
        }

        if {[catch {nsv_array get site_nodes $url} site_node_list] == 0} {
            for {set x 0} {$x < [llength $site_node_list]} {incr x 2} {
                if {[string match $url [lindex $site_node_list $x]]} {
                    array set site_node [lindex $site_node_list [expr $x + 1]]
                    if {[string equal $package_key $site_node(package_key)]} {
                        set result 1
                        break
                    } else {
                        # XXX need to figure out how to error out of here, this
                        #     really bad
                    }
                }
            }
        }

        return $result
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
    }

    ad_proc -public is_package_mounted {
        {-package_key:required}
    } {
        returns 1 if package is mounted under dotlrn, 0 otherwise
    } {
        set package_list [nsv_array get site_nodes "*$package_key*"]
        set dotlrn_ancestor_p 0

        # ns_log notice "is_package_mounted: package_list is $package_list"

        for {set x 1} {$x < [llength $package_list]} {incr x 2} {
            array set package_info [lindex $package_list $x]

            # ns_log notice "is_package_mounted: [array get package_info]"

            if {[site_node_closest_ancestor_package -default 0 -url $package_info(url) "dotlrn"] != 0} {
                set dotlrn_ancestor_p 1

                # ns_log notice "is_package_mounted: found dotlrn ancestor of $package_key with url $package_info(url)"
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

    ad_proc -public get_full_users_rel_segment_id {} {
	returns the rel_segment_id of the dotLRN full users segment
    } {
	return [db_string select_user_rel_segment {}]
    }

    ad_proc -public get_user_theme {
	user_id
    } {
	Return the user default theme
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
	set new_node_id [site_node_create $parent_node_id $mount_point]
	set new_package_id [site_node_create_package_instance $new_node_id $package_key $community_id $package_key]

	# Return the newly created package_id
	return $new_package_id
    }
	
    ad_proc -public render_page {
	{-hide_links_p  "f"}
	{-user_id  ""}
        {-render_style "individual"}
        {-page_num ""}
	portal_id
    } {
	render a page in a user's favorite style
    } {
	if {[empty_string_p $user_id]} {
	    set user_id [ad_conn user_id]
	}

	set theme_id [get_user_theme $user_id]

	return [portal::render -page_num $page_num -hide_links_p $hide_links_p -render_style $render_style $portal_id $theme_id ]
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
        {-access_level "full"}
    } {
        return the appropriate rel_type base on user type and access level
    } {
        if {[string equal $access_level "full"] == 1} {
            set rel_type "dotlrn_full_"
        } else {
            set rel_type "dotlrn_"
        }

        return "${rel_type}${type}_profile_rel"
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
            return [ad_parameter -package_id [get_package_id] -default $default $name]
        }
    }

}
