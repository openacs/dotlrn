
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

}
