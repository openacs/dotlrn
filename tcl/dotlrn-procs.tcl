
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

    ad_proc -public is_package_mounted {
        {-package_key:required}
    } {
        returns 1 if package is mounted under dotlrn, 0 otherwise
    } {
        set package_list [nsv_array get site_nodes {*${package_key}*}]
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
        {-package_key:required}
        {-url:required}
        {-directory_p:required}
    } {
        mount a package under dotlrn
    } {
        db_transaction {
            set parent_node [site_node [site_node_closest_ancestor_package_url -package_key $package_key]]
            set parent_id $parent_node(node_id)
            set parent_package_id $parent_node(object_id)

            set node_id [db_exec_plsql mount_package {
                begin
                    :1 := site_node.new(
                        node_id => acs_object_id_seq.nextval,
                        parent_id => :parent_id,
                        name => :url,
                        directory_p => :directory_p
                    );
                end;
            }

            return [site_node_create_package_instance $node_id $package_key $parent_package_id $package_key]
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
