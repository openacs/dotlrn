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
#
# /www/dotlrn-default-master.tcl
#
# This is the "default-master" template for dotlrn sites. 
#
# Instructions:
#
# 1. Put this file and it's .adp file into the server's /www directory.
# That's the one with the "default-master" tcl and adp files. You don't
# have to edit or remove the "default-master" files, since they will be
# ignored by the next step.
# 
# 2. Change the "Main Site"'s "DefaultMaster" parameter 
# from "/www/default-master" to "/www/dotlrn-default-master"
# at http://yoursite.com/admin/site-map
#
# This tells OpenACS to to use these files instead of the "default-master"
#
# 3. Edit these files to chage the look of the site including the banner
# at the top of the page, the title of the pages, the fonts of the portlets, etc.
#
# WARNING: All current portlet themes (table, deco, nada, etc) depend on some
# of the CSS defined below. Be carefull when you edit the CSS below, 
# and check how themes use it.
#
#
# Author: Arjun Sanyal (arjun@openforce.net), yon@openforce.net
#
# $Id$


set user_id [ad_get_user_id] 
set community_id [dotlrn_community::get_community_id]
set package_id [dotlrn_community::get_package_id $community_id]
set dotlrn_url [dotlrn::get_url]

if {[dotlrn::user_p -user_id $user_id]} {
    set portal_id [dotlrn::get_portal_id -user_id $user_id]
}

if {![empty_string_p $community_id]} {
    set have_comm_id_p 1
} else {
    set have_comm_id_p 0
}

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

set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id $community_id]

if {![info exists show_control_panel]} {
    if {$have_comm_id_p && $admin_p } {
        set show_control_panel 1
    } else {
        set show_control_panel 0
    }
}

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

if {![info exists control_panel_text]} {
    set control_panel_text "Control Panel"
}

if {$have_comm_id_p} {
    # get this comm's info
    set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
    set text [dotlrn_community::get_community_header_name $community_id] 
    set link [dotlrn_community::get_community_url $community_id]

    if {[empty_string_p $portal_id] && !$admin_p } {
        # not a member yet
        set portal_id [dotlrn_community::get_non_member_portal_id -community_id $community_id]
    }

    if { $have_portal_id_p && $show_navbar_p } {
        if {$show_control_panel} {
            if {$link_control_panel} {
                set extra_td_html " &nbsp; <a href=${link}one-community-admin> $control_panel_text</a>"
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
} elseif {[parameter::get -package_id $package_id -parameter community_type_level_p] == 1} {
    set extra_td_html ""
    set link_all 1
    set link [dotlrn::get_url]
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
    # we could be anywhere (maybe under /dotlrn, maybe not)
    set link "[dotlrn::get_url]/"
    set community_id ""
    set text ""
    
    if {$have_portal_id_p && $show_navbar_p} {
        if {$link_control_panel} {
            set extra_td_html " &nbsp; <a href=${link}preferences>Control Panel</a>"
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




# Developer-support support
if { [llength [namespace eval :: info procs ds_link]] == 1 } {
     set ds_link "[ds_link]"
} else {
    set ds_link ""
}


# Set up some basic stuff
set user_id [ad_get_user_id]
set full_name "[dotlrn::get_user_name $user_id]"
set title "SloanSpace"


# the ColorHack and FontHack and LogoHack!
set color_hack "#cc0000"
set color_hack_name "red"
set header_font ""
set header_font_size "medium"
set header_font_color "black"
set header_logo_item_id ""
set header_img_url "$dotlrn_url/graphics/logowhite.gif" 
set header_img_alt_text "Header Logo"

if {[empty_string_p [dotlrn_community::get_parent_community_id -package_id $package_id]]} {
    set parent_comm_p 0
} else {
    set parent_comm_p 1
}

# in a community or just under one in a mounted package like /calendar 
if {[parameter::get -package_id $package_id -parameter community_level_p] == 1 || $parent_comm_p } {
    set community_id [dotlrn_community::get_community_id]
    
    # color hack
    if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
        set color_hack "#663366"
        set color_hack_name "purple"
    } else {
        set comm_type \
                [dotlrn_community::get_community_type_from_community_id $community_id]
        if {$comm_type == "dotlrn_club"} {
            set color_hack "#006666"
            set color_hack_name "green"
        } else {
            set color_hack "#6699cc"
            set color_hack_name "blue"
        }
    }

    # font hack
    set header_font [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font
    ]
    append header_font ", "

    set header_font_size [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font_size
    ]

    set header_font_color [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font_color
    ]

    # logo hack 
    set header_logo_item_id [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_logo_item_id
    ]

    if {![empty_string_p $header_logo_item_id]} {

        set header_img_url "community-image?revision_id=$header_logo_item_id" 
    } 

    set header_logo_alt_text [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_logo_alt_text
    ]

    if {![empty_string_p $header_logo_alt_text]} {
        set header_img_alt_text $header_logo_alt_text
    } 

    # The header text is the name of the community
    set text [dotlrn_community::get_community_header_name $community_id] 

} elseif {[parameter::get -package_id $package_id -parameter community_type_level_p] == 1} {
    # in a community type
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
} else {
    # under /dotlrn
    set text $full_name    
}

# This style sheet should be moved over to an external file for performance
set header_stuff "
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">

<STYLE TYPE=\"text/css\">

BODY {
    font-family: Verdana, Arial, Helvetica, sans-serif;
    font-weight: normal;
    background: white;
    color: black;
}

img.header-img {
    /* NN4 hack */
    color: white;
    background: white;
    /* end NN4 hack */
}

.header-logo {
    color: white;
    background: white;
    width: 100px;
}

.header-text {
    font-family: $header_font Verdana, Arial, Helvetica, sans-serif;;
    font-size: $header_font_size;
    color: $header_font_color;
    background: white;
    width: 100px;
    white-space: nowrap;
}

table.element {
}

td.element-header-text {
    font-weight: bold;
    color: #ffffcc;
    background: $color_hack;     
    padding: 2px;
}

td.element-header-buttons {    
    background: $color_hack;
    color: $color_hack;
    white-space: nowrap;
}

img.element-header-button {
    color: $color_hack;
    background: $color_hack;
}

.element-content {    
    border-width: 1px;
    border-style: solid;
    border-color: black;
}

.navbar {
    font-size: small;
}

.footer {
    font-size: x-small;
}

.navbar A {
    background: #eeeeee;
}

</STYLE>
"
