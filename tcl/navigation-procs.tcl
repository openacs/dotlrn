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

    Procs for dotLRN navigation

    @author ben@openforce.net
    @creation-date 2001-11-10

}

namespace eval dotlrn {

    ad_proc -public admin_navbar {
        args
    } {
        do an admin navbar
    } {
        # Prepend some args
        set first_args [list [list [get_url] "dotLRN"]]
        if {[llength $args] > 0} {
            lappend first_args [list [get_admin_url] Admin]
        } else {
            lappend first_args Admin
        }

        set args [concat $first_args $args]

        return [raw_navbar $args]
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

        set first_args []
        lappend first_args [list [get_url] dotLRN]

        if {[string equal ${community_type} "dotlrn_class_instance"] != 0} {
            lappend first_args [list [dotlrn_community::get_community_type_url $community_type] [parameter::get -parameter classes_pretty_plural]]
        } elseif {[string equal ${community_type} "dotlrn_club"] != 0} {
            lappend first_args [list [dotlrn_community::get_community_type_url $community_type] [parameter::get -parameter clubs_pretty_plural]]
        } elseif {[string equal ${community_type} "dotlrn_community"] != 0} {
        } else {
            lappend first_args [list [dotlrn_community::get_community_type_url $community_type] [dotlrn_community::get_community_type_name $community_type]]
        }

        if {![empty_string_p $community_id]} {
            lappend first_args [list [dotlrn_community::get_community_url $community_id] [dotlrn_community::get_community_name $community_id]]
        }

        return [raw_navbar [concat $first_args $args]]
    }

    ad_proc -public raw_navbar {
        list_of_args
    } {
        do the raw navbar thing (both for admin and such)
    } {
        set args $list_of_args
        set list_of_links [list]
        set total_n_args [llength $args]
        set count 0

        foreach arg $args {
            incr count
            if {[llength $arg] == 2 && $count < $total_n_args} {
                lappend list_of_links "<a href=\"[lindex $arg 0]\">[lindex $arg 1]</a>"
            } else {
                lappend list_of_links "$arg"
            }
        }

        return "[join $list_of_links " &gt; "]<br>"
    }

}
