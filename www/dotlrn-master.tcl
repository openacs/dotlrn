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
#
# /www/dotlrn-master.tcl
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

ad_page_contract {

    Q: What is this file?

    A: This is the master template for dotlrn. It sets up the navbar and
    dynamically generates a CSS file for the dotlrn banner color, font, header 
    image, and the portal themes.

    Q: How do I use this file?

    A: This template is meant to replace your OpenACS default-master template.    
    
    To do this change the "Main Site"'s "DefaultMaster" parameter 
    from "/www/default-master" to "/packages/dotlrn/www/dotlrn-master"
    at http://yoursite.com/admin/site-map

    Q: Do I have to replace my site's default-master template with this 
    one for dotlrn to work?

    A: Yes

    Q: How do I customize the banner, images, CSS, etc?

    A: You can change the default banner and generated CSS by editing this template
    and the associated ADP.

    WARNING: Some portal themes depend on the CSS generated below. Be careful when
    you edit the CSS below and check that the portal theme has not broken.

    @author arjun (arjun@openforce.net)
    @version $Id$

}

#
# Set up some basic vars
# 
set user_id [ad_get_user_id] 
set dotlrn_url [dotlrn::get_url]
set dotlrn_graphics_url "/graphics"

#
# Get passed in properties
#

# title - if passed in appends it to the default title
set default_title "dotLRN"

if {![info exists title]} {
    set title $default_title
} else {
    set title "$default_title : $title"
}

# no_navbar_p - a property to turn off the navbar, not currently used
if {![info exists no_navbar_p]} {
    set no_navbar_p 0
}

# link_control_panel - a special property used by "control-panel" pages
if {![info exists link_control_panel]} {
    set link_control_panel 1
}

#                    
# navbar generation
#
if {!$no_navbar_p} {
    set navbar [dotlrn::portal_navbar \
        -user_id $user_id \
        -link_control_panel $link_control_panel \
        -control_panel_text [_ "dotlrn.control_panel"]
    ]
} else {
    set navbar "<br>"
}

# the ColorHack and FontHack and LogoHack!
set color_hack "#cc0000"
set color_hack_name "red"
set color_1pixel "/shared/1pixel.tcl?[export_vars { { r 204 } { g 0 } { b 0 }}]"

set header_font ""
set header_font_size "medium"
set header_font_color "black"
set header_logo_item_id ""
set header_img_url "$dotlrn_graphics_url/dotlrn.gif" 
set header_img_alt_text [_ "dotlrn.header_logo"]


# gets the package_id for the passed in dotlrn instace,
# if the community_id is invalid, returns the pacakge_id of the 
# main dotlrn instance ???
set community_id [dotlrn_community::get_community_id]
set package_id [dotlrn_community::get_package_id $community_id]

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
        set color_1pixel "/shared/1pixel.tcl?[export_vars { { r 153 } { g 102 } { b 153 }}]"
    } else {
        set comm_type \
                [dotlrn_community::get_community_type_from_community_id $community_id]
        if {$comm_type == "dotlrn_club"} {
            set color_hack "#006666"
            set color_hack_name "green"
            set color_1pixel "/shared/1pixel.tcl?[export_vars { { r 0 } { g 102 } { b 102 }}]"
        } else {
            set color_hack "#6699cc"
            set color_hack_name "blue"
            set color_1pixel "/shared/1pixel.tcl?[export_vars { { r 102 } { g 153 } { b 204 }}]"
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
    set text "[dotlrn::get_user_name $user_id]"
}

if { ![info exists header_stuff] } {
    set header_stuff ""
}

# This style sheet should be moved over to an external file for performance
append header_stuff "
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
    width: 140px;
}

.header-buttons {
    vertical-align: middle;
    text-align: right;
}

.header-text {
    font-family: $header_font Verdana, Arial, Helvetica, sans-serif;;
    font-size: $header_font_size;
    color: $header_font_color;
    background: white;
    white-space: nowrap;
    padding-left: 20px;
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

td.element-header-plain {
    color: black;
    background: \#ddddff;
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

# Developer-support support
set ds_enabled_p [parameter::get_from_package_key \
    -package_key acs-developer-support \
    -parameter EnabledOnStartupP \
    -default 0
]

if {$ds_enabled_p} {
    set ds_link [ds_link]
} else {
    set ds_link {}
}

ad_return_template

