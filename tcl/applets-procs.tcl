
#
# Procs for DOTLRN Class Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# October 1st, 2001
#

ad_library {
    Procs to manage dotLRN Applets

    @author ben@openforce.net
    @creation-date 2001-10-01
}

namespace eval dotlrn_applet {

    ad_proc -public get_url {} {
        # MAJOR FIXME NOW
        return "/dotlrn/applets"
    }

    ad_proc -public get_applet_url {
        {-applet_key:required}
    } {
        return [site_nodes::get_info -return url -package_key $applet_key]
    }

    ad_proc -public init {} {
        # Create the applets node
        site_nodes::site_node_create -parent_node_id [dotlrn::get_node_id] -name "applets"
    }

    ad_proc -public register {
	applet_key
    } {
	Register an applet.
    } {
	# Check if it's registered

	# Add it
	nsv_lappend dotlrn applets $applet_key
    }

    ad_proc -public deregister {
	applet_key
    } {
	Deregister an applet. Not currently threadsafe!
    } {
	# If the array hasn't even been created! The Horror!
	if {![nsv_exists dotlrn applets]} {
	    return
	}

	# Get the list, remove the element, reset the list
	set current_list [nsv_get dotlrn applets]
	set index [lsearch -exact $current_list $applet_key]
	set new_list [lreplace $current_list $index $index]

	nsv_set dotlrn applets $new_list
    }

    ad_proc -public list_applets {
    } {
	List all registered applets.
    } {
	return [nsv_get dotlrn applets]
    }

    ad_proc -public applet_exists_p {
        {-applet_key:required}
    } {
        check whether "applet_key" is a real dotLRN applet
    } {
        return [db_string select_applet_exists_p {}]
    }

    ad_proc -public add_applet_to_dotlrn {
        {-applet_key:required}
        {-activate_p "t"}
    } {
        dotlrn-init.tcl calls AddApplet on all applets using acs_sc directly.
        The add_applet proc in the applet (e.g. dotlrn-calendar) calls this
        proc to tell dotlrn to register and/or activate itself. This _must_
        be able to be run multiple times!
    } {

        if {![empty_string_p [get_applet_id_from_key -applet_key $applet_key]]} {
            return
        }

        if {[string equal $activate_p "t"] == 1} {
            set status "active"
        } else {
            set status "inactive"
        }

        db_transaction {
            set applet_id [db_nextval acs_object_id_seq]
            db_dml insert {}
        }
    }

    ad_proc -public get_applet_id_from_key {
        {-applet_key:required}
    } {
        get the id of the dotlrn applet from the applet key or the null
        string if the key dosent exist
    } {
        return [db_string select {} -default ""]
    }

    ad_proc -public mount {
        {-package_key:required}
        {-url ""}
        {-pretty_name ""}
    } {
        if {[empty_string_p $url]} {
            set url $package_key
        }

        if {[empty_string_p $pretty_name]} {
            set pretty $package_key
        }

        # Find the parent node
        set applets_url [get_url]
        set parent_node_id [site_node_id $applets_url]

        # Mount it baby
        set package_id [dotlrn::mount_package \
                -parent_node_id $parent_node_id \
                -package_key $package_key \
                -url $url \
                -directory_p t \
                -pretty_name $pretty_name]

        return $package_id
    }
        
        
}
