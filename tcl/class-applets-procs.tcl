
#
# Procs for DOTLRN Class Management, Applets
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 18th, 2001
#

ad_library {

    Procs to manage DOTLRN Classes

    @author ben@openforce.net
    @creation-date 2001-08-18

}

namespace eval dotlrn_class_applets {

    ad_proc -public register_applet {
	name
	pretty_name
	description
	list_of_callbacks
    } {
	Registers an applet that is available for DOTLRN to manage

	This registers a list of callbacks, in the following form:
	{{NEW_CLASS_INSTANCE dotlrn_bboard::new_class_instance}
	{GET_PORTLET_CONTENT dotlrn_bboard::get_portlet_content}}
    } {
	if {[nsv_exists DOTLRN_APPLETS $name]} {
	    deregister_applet $name
	}

	# register things in the global array
	nsv_set DOTLRN_APPLETS $name [list $pretty_name $description $list_of_callbacks]
    }

    ad_proc -public deregister_applet {
	name
    } {
	Deregisters an applet for DOTLRN
    } {
	set applet [nsv_get DOTLRN_APPLETS $name]

	# Perform the callback to clean things up before deregistration
	call_callback $applet DEREGISTER

	nsv_unset DOTLRN_APPLETS $name
    }

    ad_proc -public get_available_applets {
    } {
	returns the list of available "applets" for DOTLRN. This will usually include
	bboard, file-storage, FAQ, etc...
    } {
	return [nsv_names DOTLRN_APPLETS]
    }

    ad_proc call_callback {
	applet
	callback_name
	args
    } {
	Perform the callback on a particular method for a particular applet
    } {
	set list_of_callbacks [lindex $applet 2]

	foreach callback $list_of_callbacks {
	    if {[string equal [lindex $callback 0] $callback_name]} {
		eval [lindex $callback 1] $args
	    }
	}
    }
}
