
#
# Procs for DOTLRN navigation
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# November 10th, 2001
#

ad_library {
    
    Procs for dotLRN navigation
    
    @author ben@openforce.net
    @creation-date 2001-11-10
    
}

namespace eval dotlrn {

    ad_proc -public root_url {
    } {
	return "/dotlrn"
    }

    ad_proc -public navbar {
	{ -community_id "" }
	{ -community_type "" }
	args
    } {
	Creates a Navigation Bar for dotLRN
    } {
	# Fetch community_id and community_type if they're not there
	if {[empty_string_p $community_id] && [empty_string_p $community_type]} {
	    set community_id [dotlrn_community::get_community_id]
	    set community_type [dotlrn_community::get_community_type]
	}

	if {![empty_string_p $community_id]} {
	    set community_type [dotlrn_community::get_community_type_from_community_id $community_id]
	}

	set list_of_links [list "<a href=[root_url]>dotLRN</a>"]

	lappend list_of_links "<a href=[dotlrn_community::get_community_type_url $community_type]>[dotlrn_community::get_community_type_name $community_type]</a>"

	if {![empty_string_p $community_id]} {
	    lappend list_of_links "<a href=[dotlrn_community::get_community_url $community_id]>[dotlrn_community::get_community_name $community_id]</a>"
	}

	foreach arg $args {
	    if {[llength $arg] == 2} {
		lappend list_of_links "<a href=\"[lindex $arg 0]\">[lindex $arg 1]</a>"
	    } else {
		lappend list_of_links "$arg"
	    }
	}

	return "[join $list_of_links " &gt; "]<br>"
    }
	
}
