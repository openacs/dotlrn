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
    Procs for navigating dotLRN

    @author ben@openforce
    @creation-date 2002-03-18
}

namespace eval dotlrn_navbar {
    
    ad_proc -public navbar_links {
	{-url ""}
	{-links:required}
    } {
	set list_of_links [list [list [dotlrn::get_url] dotLRN]]

	# Determine if we're in a community
	set community_id [dotlrn_community::get_community_id_from_url -url $url]

	if {![empty_string_p $community_id]} {
	    lappend list_of_links [list [dotlrn_community::get_community_url $community_id] \
		    [dotlrn_community::get_community_name $community_id]]
	}

	set list_of_links [concat $list_of_links $links]

	return $list_of_links
    }

}
