#
#  Copyright (C) 2001, 2002 MIT
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

    Procs for dotLRN navigation, including helper procs for dotlrn-master

    @author ben@openforce.net
    @author arjun@openforce.net
    @version $Id$

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

    ad_proc -public portal_navbar {
        {-user_id:required}
        {-link_control_panel:required}
        {-control_panel_text:required}
    } {
        A helper procedure that generates the PORTAL navbar (the thing
        with the portal pages on it) for dotlrn. It is called from the
        dotlrn-master template
    } {
                
        set dotlrn_url [dotlrn::get_url]
        set community_id [dotlrn_community::get_community_id]
        set control_panel_name control-panel
        set link_all 0
    
        if {[empty_string_p $community_id]} {
            # We are not under a dotlrn community. However we could be
            # under /dotlrn (i.e. in the user's portal) or anywhere
            # else on the site
            set link "[dotlrn::get_url]/"
            
            if {[dotlrn::user_p -user_id $user_id]} {
                # this user is a dotlrn user, show their personal portal
                # navbar, including the control panel link
                set portal_id [dotlrn::get_portal_id -user_id $user_id]
                set show_control_panel 1
            } else {
                # not a dotlrn user, so no user portal to show
                set portal_id {}
                set show_control_panel 0
            }

        } else {
            #
            # We are under a dotlrn community. Get the community's portal_id, etc.
            #
            
            # some defaults
            set text [dotlrn_community::get_community_header_name $community_id] 
            set control_panel_name one-community-admin
            set link [dotlrn_community::get_community_url $community_id]
        
            # figure out what this privs this user has on the community
            set admin_p [dotlrn::user_can_admin_community_p \
                -user_id $user_id \
                -community_id $community_id
            ]
        
            if {!$admin_p} {
                # the user can't admin this community, perhaps they are a
                # humble member instead?
                set member_p [dotlrn_community::member_p $community_id $user_id]
                set show_control_panel 0
            } else {
                # admins always get the control_panel_link, unless it's
                # explictly turned off
                set show_control_panel 1
            }
        
            if {$admin_p || $member_p} {
    
                set portal_id [dotlrn_community::get_portal_id \
                    -community_id $community_id
                ]
            } else {
                # show this person the comm's non-member-portal
                set portal_id [dotlrn_community::get_non_member_portal_id \
                    -community_id $community_id
                ]
            }
        }

        #
        # Common code for the the behavior of the control panel link
        #
        if {$show_control_panel} {
            if {$link_control_panel} {
                set extra_td_html \
                    " &nbsp; <a href=$link$control_panel_name>$control_panel_text</a>"
            } else {
                set extra_td_html " &nbsp; <strong>$control_panel_text</strong>"
                set link_all 1
            } 
        } else {
            set extra_td_html {}
        } 
    
        # Actually generate the navbar, if we got a valid portal_id
        if {![empty_string_p $portal_id]} {
            set navbar [portal::navbar \
                -portal_id $portal_id \
                -link $link \
                -link_all $link_all \
                -pre_html "" \
                -post_html "" \
                -extra_td_html $extra_td_html \
                -table_html_args "class=\"navbar\""]
        }
    }

}
