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
        return dotlrn_community
    }

    ad_proc -public class_group_type_key {
    } {
	Returns the group type key used for class groups
    } {
	return [dotlrn::parameter -name class_group_type_key]
    }

    ad_proc -public group_type_key {
    } {
	Returns the group_type key that is being used for class management
    } {
	return [dotlrn::parameter -name group_type_key]
    }

    ad_proc -public package_key {} {
	returns the package key
    } {
	return dotlrn
    }

    ad_proc -public get_url {} {
	returns the root URL for dotLRN
    } {
	return "/[package_key]"
    }

    ad_proc -public get_admin_url {} {
	returns the root URL for dotLRN
    } {
	return "[get_url]/admin"
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
        create base community_type for dotlrn and create the user and subgroups
        portal templates
    } {
        db_transaction {
            dotlrn_community::set_type_package_id [community_type] [get_package_id]
            
            dotlrn::new_type_portal \
                -type user \
                -pretty_name [dotlrn::parameter -name user_portal_pretty_name]
            
            # do the same for subgroups (the dotlrn_community type)
            dotlrn::new_type_portal \
                -type dotlrn_community \
                -pretty_name [dotlrn::parameter -name subcommunities_pretty_plural]
        }
    }

    ad_proc -public is_package_mounted {
        {-package_key:required}
    } {
        returns 1 if package is mounted under dotlrn, 0 otherwise
        FIXME: refactor
    } {
        set package_list [nsv_array get site_nodes "*$package_key*"]
        set dotlrn_ancestor_p 0

        for {set i 1} {$i < [llength $package_list]} {incr i 2} {
            array set package_info [lindex $package_list $i]

            if {[site_node_closest_ancestor_package -default 0 -url $package_info(url) [package_key]] != 0} {
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
            array set parent_node [site_node::get -node_id $parent_node_id]
            set parent_package_id $parent_node(object_id)

            ns_log notice "dotlrn::mount_package: [array get parent_node]"

            if {[empty_string_p $pretty_name]} {
                set pretty_name $package_key
            }

            set package_id [site_node_apm_integration::new_site_node_and_package \
                -name $url \
                -parent_id $parent_node_id \
                -package_key $package_key \
                -instance_name $pretty_name \
                -context_id $parent_package_id \
            ]
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
                -node_id [site_node::get_node_id_from_object_id -object_id $package_id]
        }
    }

    ad_proc -public get_community_applet_node_id {
        {-community_id:required}
        {-package_key:required}
    } {
        returns the node_id of the applet in the given community. 
        this should probably be done by querying the dotlrn_community_applets table
        directly, but we can do it through site_map:: too
    } {
        set parent_node_id [site_node::get_node_id_from_object_id \
            -object_id [dotlrn_community::get_package_id $community_id]
        ]

        return [site_nodes::get_node_id_from_child_name \
            -parent_node_id $parent_node_id \
            -name $package_key \
        ]
    }

    ad_proc -public get_community_applet_package_id {
        {-community_id:required}
        {-package_key:required}
    } {
        like above but returns the package_id
    } {
        set node_id [get_community_applet_node_id \
            -community_id $community_id \
            -package_key $package_key
        ]

        return [site_node::get_object_id -node_id $node_id]
    }
        
    ad_proc -public unmount_community_applet_package {
        {-community_id:required}
        {-package_key:required}
    } {
        unmount a package from under a community. 
        should be in dotlrn_community::
    } {
        db_transaction {
            set child_node_id [get_community_applet_node_id \
                    -community_id $community_id \
                    -package_key $package_key
            ]
            
            # site node del package instance
            site_node_delete_package_instance -node_id $child_node_id
        }
    }

    ad_proc -public get_node_id {} {
	return the root node id for dotLRN
    } {
	return [site_node::get_node_id -url [get_url]]
    }

    ad_proc -public get_package_id {} {
	return the package ID for dotLRN
    } {
        return [site_node::get_object_id -node_id [get_node_id]]
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

    ad_proc -public get_portal_id {
	{-user_id:required}
    } {
	Get the portal_id for a particular user
    } {
        return [util_memoize "dotlrn::get_portal_id_not_cached -user_id $user_id"]
    }

    ad_proc -private get_portal_id_not_cached {
	{-user_id:required}
    } {
	Get the portal_id for a particular user
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
	# we have a problem here.
	set parent_node_id [db_string select_node_id {}]

        set new_package_id [site_node_apm_integration::new_site_node_and_package \
            -name $mount_point \
            -parent_id $parent_node_id \
            -package_key $package_key \
            -instance_name $package_key \
            -context_id $package_id \
        ]

	# Return the newly created package_id
	return $new_package_id
    }
	
    ad_proc -public render_page {
	{-workspace_p ""}
	{-hide_links_p  f}
        {-render_style individual}
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
        {-name:required}
        {-default ""}
    } {
        wrap 
    } {
        return [parameter::get -package_id [get_package_id] -parameter $name -default $default]
    }

    ad_proc -public set_type_portal_id {
        {-type:required}
        {-portal_id:required}
    } {
        set the portal_id for this template type in the dotlrn_portal_types_map table
    } {
        db_dml insert {}
    }

    ad_proc -public get_type_from_portal_id {
        {-portal_id:required}
    } {
        Get the type from the passed in portal_id from the dotlrn_portal_types_map table
    } {
        return [db_string select {}]
    }

    ad_proc -public get_portal_id_from_type {
        {-type:required}
    } {
        What's this type's portal_id? If the type is not matched, 
        return the id of dotlrn_class_instance by default
    } {
        set id [db_string select {} -default ""]

        if {[empty_string_p $id]} {
            set type dotlrn_class_instance
            set id [db_string select {}]
        } 

        return $id
    }

    ad_proc -public new_type_portal {
        {-type:required}
        {-pretty_name:required}
    } {
        Create a portal for the given type. This is how "portal templates"
        (actually just regular portals) are created for things like the
        "user" portal, "communities", or "class instances". We can't just
        associate a portal_id with a dotlrn community_type since there's 
        no community type for a "user" portal. So we use the 
        dotlrn_portal_types_map table instead.

        @param type
        @param pretty_name
        @return portal_id
    } {
        # based on the type:
        # 1. get the page_names and layouts
        # 2. the the list of default applets for this type
        if {[string equal $type dotlrn_community]} {
            set csv_list [dotlrn::parameter -name subcomm_pages_csv]
            set default_applets [dotlrn::parameter -name default_subcomm_applets]
        } elseif {[string equal $type dotlrn_club]} {
            set csv_list [dotlrn::parameter -name club_pages_csv]
            set default_applets [dotlrn::parameter -name default_club_applets]
        } elseif {[string equal $type user]} {
            set csv_list [dotlrn::parameter -name user_portal_pages_csv]
            set default_applets [dotlrn::parameter -name default_user_portal_applets]
        } else {
            set csv_list [dotlrn::parameter -name class_instance_pages_csv]
            set default_applets [dotlrn::parameter -name default_class_instance_applets]
        }
        
        # FIXME - if there's a proc to get the admin user_id w/o 
        # a connection put it here. This needs to be a vaild
        # grantee for the perms
        set user_id -1        
        
        set portal_id [portal::create \
                           -name "$pretty_name Portal" \
                           -csv_list $csv_list \
                           $user_id
                           
        ]
        
        # Associate this type with portal_id, must be before applet
        # callbacks, since they use this info
        set_type_portal_id \
            -type $type \
            -portal_id $portal_id

        # Add the default applets 
        set default_applets_list [string trim [split $default_applets {,}]]
        
        foreach applet_key $default_applets_list {
            if {[dotlrn_applet::applet_exists_p -applet_key $applet_key]} {
                dotlrn_community::applet_call $applet_key AddPortlet [list $portal_id]
            }
        }
    }

}
