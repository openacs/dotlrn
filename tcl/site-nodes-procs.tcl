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

ad_library {
    Tcl procs for interface with the site-node data model.

    @author yon@openforce.net
    @creation-date 2001-12-07
    @version $Id$
}

namespace eval site_nodes {

    ad_proc -public get_node_id_from_package_id {
        {-package_id:required}
    } {
        get node_id of a package instance
    } {
        return [db_string get_node_id_from_package_id {
            select node_id
            from site_nodes
            where object_id = :package_id
        }]
    }

    ad_proc -public get_package_id_from_node_id {
        {-node_id:required}
    } {
        get package_id from a node id
    } {
        return [db_string get_package_id_from_node_id {
            select object_id 
            from site_nodes
            where node_id = :node_id
        }]
    }

    ad_proc -public get_url_from_package_id {
        {-package_id:required}
    } {
        get node_id of a package instance
    } {
        return [db_string get_node_id_from_package_id {
            select site_node.url(node_id)
            from site_nodes
            where object_id = :package_id
        }]
    }

    ad_proc -public get_url_from_node_id {
        {-node_id:required}
    } {
        get url from node_id
    } {
        return [db_string get_url_from_node_id {
            select site_node.url(:node_id) from dual
        }]
    }

    ad_proc -public get_node_id_from_child_name {
        {-parent_node_id:required}
        {-name:required}
    } {
        return [db_string get_child_node_id {
            select node_id from site_nodes where parent_id = :parent_node_id
            and name = :name} -default ""]
    }

    ad_proc -public get_node_id_from_url {
        {-url:required}
        {-parent_node_id ""}
    } {
        get node_id from url
    } {
        return [db_exec_plsql get_node_id_from_url {
            begin
                :1 := site_node.node_id(url => :url, parent_id => :parent_node_id);
            end;
        }]
    }

    ad_proc -public get_parent_id {
        {-node_id ""}
        {-instance_id ""}
    } {
        get the parent_id (a node_id) of this node_id
    } {
        if {![empty_string_p $node_id]} {
            return [db_string select_parent_by_node_id {}]
        } elseif {![empty_string_p $instance_id]} {
            return [db_string select_parent_by_instance_id {}]
        } else {
            ns_log error "site_nodes::get_parent_id Bad params!"
            ad_return_complaint 1  "site_nodes::get_parent_id Bad params! Tell your admin."
        }
    }

    ad_proc -public get_parent_object_id {
        {-instance_id ""}
    } {
        get the object_id (not node_id!) of the parent of this instance
    } {
        return [db_string select_parent_oid_by_instance_id {} -default ""]
    }

    ad_proc -public get_parent_name {
        {-instance_id ""}
    } {
        get the name of the parent of this instance
    } {
        return [util_memoize "site_nodes::get_parent_name_not_cached -instance_id $instance_id"]
    }

    ad_proc -public get_parent_name_not_cached {
        {-instance_id ""}
    } {
        memoizing helper
    } {
        return [db_string select_parent_name_by_id {} -default ""]
    }

    # site_nodes_list procs

    ad_proc -public get_site_nodes_list {
    } {
        Return the list-ified site_nodes array.
    } {
        return [nsv_array get site_nodes]
    }

    ad_proc -public get_site_nodes_list_key {
        {-site_nodes_list:required}
        {-index:required}
    } {
        return [lindex $site_nodes_list $index]
    }

    ad_proc -public get_site_nodes_list_value {
        {-site_nodes_list:required}
        {-index:required}
    } {
        return [lindex $site_nodes_list [expr $index + 1]]
    }


    ad_proc -public get_site_nodes_list_value_param {
        {-site_nodes_list:required}
        {-index:required}
        {-param:required}
    } {
        The 'site_nodes' nsv_array is chock full of information
        about every package mounted on every node in the system, let's
        access that information.

        Here's a sample:
        key = /portal/

        value = directory_p t
        object_type apm_package
        package_key new-portal
        package_id 3482
        pattern_p t
        node_id 3481
        url /portal/
        object_id 3482

        @author arjun@openforce.net
    } {

        #ns_log notice "aks12 llength [llength $site_nodes_list]"

        array set snlv [get_site_nodes_list_value \
                -site_nodes_list $site_nodes_list \
                -index $index]

	switch $param {
	    "directory_p" {
                return $snlv(directory_p)
	    }
	    "object_type" {
                return $snlv(object_type)
	    }
	    "package_key" {
                return $snlv(package_key)
	    }
	    "package_id" {
                return $snlv(package_id)
	    }
	    "pattern_p" {
                return $snlv(pattern_p)
	    }
	    "node_id" {
                return $snlv(node_id)
	    }
	    "url" {
                return $snlv(url)
	    }
	    "object_id" {
                return $snlv(object_id)
	    }
            default {
 		ns_log Error \
			"site_nodes::get_site_nodes_list_value_param failed! \n
                bad param ($param) was specified"
		ad_return_complaint 1 \
			"site_nodes::get_site_nodes_list_value_param failed! \n
                bad param ($param) was specified"
            }
        }
    }

    ad_proc -private get_info {
        {-return:required}
        {-param ""}
        {-package_key:required}
    } {
        returns either 1. number of times this package_key is mounted
        2. the url a singleton is mounted at (or the first match it finds
        for a multi-mounted package) or 3. a singleon's param (see list above).
        Same deal appiles to non-singletons

        ret = count, url, param
    } {

        set get_count_p 0
        set get_url_p 0
        set get_param_p 0

        if {$return == "count"} {
            set get_count_p 1
            set $param "package_key"
        } elseif {$return == "url"} {
            set get_url_p 1
        } elseif {$return == "param"} {
            if {[empty_string_p $param]} {
 		ns_log Error \
			"site_nodes::get_info failed! \n
                no param specified to get"
		ad_return_complaint 1 \
			"site_nodes::get_info failed! \n
                no param specified to get"
            } else {
                set get_param_p 1
            }
        }

        set site_nodes_list [get_site_nodes_list]

        #        ad_return_complaint 1 "aks 17 $site_nodes_list"

        # iterate through the array, counting the number of times the
        # passed in package key is in the site_nodes array
        set count 0

        for {set x 0} {$x < [llength $site_nodes_list]} {incr x 2} {

            set key [get_site_nodes_list_key \
                    -site_nodes_list $site_nodes_list \
                    -index $x]

            if {$get_url_p} { return $key }

            set poss_key_match [get_site_nodes_list_value_param \
                    -site_nodes_list $site_nodes_list \
                    -index $x \
                    -param "package_key"]

            if { $poss_key_match == $package_key} {

                if {$get_param_p} {
                    return [get_site_nodes_list_value_param \
                            -site_nodes_list $site_nodes_list \
                            -index $x \
                            -param $param]
                }

                incr count
            }
        }

        if {$get_count_p} {
            return $count
        } else {
            ns_log error "site_nodes::get_info get_count_p assertion failed!\n
            we should never get here"
        }
    }

    ad_proc -public mount_count {
        {-package_key:required}
    } {
        returns the number of times this package_key is mounted
    } {
        return [get_info -return count -package_key $package_key]
    }

    ad_proc -public singleton_p {
        {-package_key:required}
    } {
        is this package a singleton?
    } {
        if {[package_mount_count -package_key $package_key] == 1} {
            return 1
        }
        return 0
    }

    ad_proc -public site_node_create {
        {-node_id ""}
        {-parent_node_id:required}
        {-name:required}
        {-directory_p "t"}
    } {
        create a site node the real way (the site-node stuff needs a user_id)
    } {
        set node_id [db_exec_plsql create_node {
            begin
                :1 := site_node.new(
                    node_id => :node_id,
                    parent_id => :parent_node_id,
                    name => :name,
                    directory_p => :directory_p,
                    pattern_p => 't'
                );
            end;
        }]

        return $node_id
    }

}
