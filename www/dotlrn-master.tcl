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

# /www/dotlrn-master.tcl
#
# The dotlrn master template
# 
# All adp pages in /dotlrn/www should point to this (local) master
# template by adding the following line at the top of the adp:
# 
# <master src="dotlrn-master">
#
# More: This is 1) where the navbar for portal pages gets generated. 
# Any CUSTOM CODE for your site should be put in
# " ACS-ROOT/www/site-specific-master"
# 
#
# Author: Arjun Sanyal (arjun@openforce.net)
#
# $Id$
#

# here's a bunch of stuff that an adp may optionally set to alter the
# master's behavior

# portal_id 
if {[exists_and_not_null portal_id]} {
    set have_portal_id_p 1
} else {
    set have_portal_id_p 0 
}

# navbar vars
set show_navbar_p 1
if {[exists_and_not_null no_navbar_p]} {
    set show_navbar_p 0
} 

if {![info exists link_all]} {
    set link_all 0
}

if {![info exists return_url]} {
    set link [ad_conn -get extra_url]
} else {
    set link $return_url
}

if {![info exists show_control_panel]} {
    set show_control_panel 0
}

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

if {![info exists control_panel_text]} {
    set control_panel_text "Control Panel"
}


if {[ad_parameter community_level_p] == 1} {
    # in a community
    set community_id [dotlrn_community::get_community_id]

    # The header text is the name of the community
    set text [dotlrn_community::get_community_header_name $community_id] 

    if { $have_portal_id_p && $show_navbar_p } {
        if {$show_control_panel} {
            if {$link_control_panel} {
                set extra_td_html " &nbsp; <a href=one-community-admin> $control_panel_text</a>"
            } else {
                set extra_td_html " &nbsp; $control_panel_text"
            }
        } else {
            # don't show control panel
            set extra_td_html ""
        }
            
        set navbar [portal::navbar \
                -portal_id $portal_id \
                -link_all $link_all \
                -link $link \
                -pre_html "" \
                -post_html "" \
                -extra_td_html $extra_td_html \
                -table_html_args "class=\"navbar\""]
    } else {
        set navbar "<br>"
        set portal_id ""
    }
} elseif {[ad_parameter community_type_level_p] == 1} {
    # in a community type
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
    
    if {$have_portal_id_p && $show_navbar_p} {
        
        set navbar [portal::navbar \
                -portal_id $portal_id \
                -link_all $link_all \
                -link $link \
                -pre_html "" \
                -post_html "" \
                -extra_td_html $extra_td_html \
                -table_html_args "class=\"navbar\""]
    } else {
        set navbar "<br>"
        set portal_id ""
    }
 
} else {
    # under /dotlrn
    set community_id ""
    set text ""
    
    if {$have_portal_id_p && $show_navbar_p} {
        if {$link_control_panel} {
            set extra_td_html " &nbsp; <a href=preferences>Control Panel</a>"
        } else {
            set extra_td_html " &nbsp; Control Panel"
        }

        set navbar [portal::navbar \
                -portal_id $portal_id \
                -link_all $link_all \
                -link $link \
                -pre_html "" \
                -post_html "" \
                -extra_td_html $extra_td_html  \
                -table_html_args "class=\"navbar\""]
    } else {
        set navbar "<br>"
        set portal_id ""
    }
}
