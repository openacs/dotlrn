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
# from "/www/default-master" to "/www/dotlrn-master"
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
set dotlrn_url [dotlrn::get_url]


#Scope Related graphics/css parameters
# Set everything for user level scope as default then modify it later as we refine the scope.
set scope_name "user"
set scope_main_color "#003366"
set scope_header_color "#6DB2C9"
set scope_highlight_text "white"
set scope_z_dark "#C9D7DC"
set scope_z_light "#EAF0F2"
set scope_light_border "#DDEBF5"
set help_url "[dotlrn::get_url]/control-panel"
set header_font "Arial, Helvetica, sans-serif"
set header_font_size "medium"
set header_font_color "black"
set header_logo_item_id ""
set header_img_url "$dotlrn_url/resources/logo" 
set header_img_file "[acs_root_dir]/packages/dotlrn/www/resources/logo"
set header_img_alt_text "Header Logo"

set extra_spaces "<img src=$dotlrn_url/resources/spacer.gif border=0 width=15>"
set td_align "align=\"center\" valign=\"top\""

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
if {[exists_and_not_null no_navbar_p] && $no_navbar_p} {
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

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

if { ![string equal [ad_conn package_key] [dotlrn::package_key]] } {
    # Peter M: We are in a package (an application) that may or may not be under a dotlrn instance 
    # (i.e. in a news instance of a class)
    # and we want all links in the navbar to be active so the user can return easily to the class homepage
    # or to the My Space page
    set link_all 1
}

if {$have_comm_id_p} {
    # in a community or just under one in a mounted package like /calendar 
    # get this comm's info
    set control_panel_text "Administer"

    set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
    set text [dotlrn_community::get_community_header_name $community_id] 
    set link [dotlrn_community::get_community_url $community_id]
    set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id -community_id $community_id]

    if {[empty_string_p $portal_id] && !$admin_p } {
        # not a member yet
        set portal_id [dotlrn_community::get_non_member_portal_id -community_id $community_id]
    }

    if { $have_portal_id_p && $show_navbar_p } {
	set make_navbar_p 1

    } else {
	set make_navbar_p 0
        set portal_id ""
    }
} elseif {[parameter::get -parameter community_type_level_p] == 1} {
    set control_panel_text "Administer"

    set extra_td_html ""
    set link_all 1
    set link [dotlrn::get_url]
    # in a community type
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
    
    if {$have_portal_id_p && $show_navbar_p} {
	set make_navbar_p 1
    } else {
	set make_navbar_p 0
        set portal_id ""
    }
} else {
    # we could be anywhere (maybe under /dotlrn, maybe not)
    set control_panel_text "My Account"
    set link "[dotlrn::get_url]/"
    set community_id ""
    set text ""
    set make_navbar_p 1
    if {$have_portal_id_p && $show_navbar_p} {
    } else {
	set make_navbar_p 0
	set portal_id ""
    }
}

if { $make_navbar_p } {
    if {$link_control_panel} {
	set link_control_panel 1
    } else {
	set link_control_panel 0
    }
    set extra_spaces "<img src=$dotlrn_url/resources/spacer.gif border=0 width=15>"    
    set navbar [dotlrn::portal_navbar \
        -user_id $user_id \
        -link_control_panel $link_control_panel \
        -control_panel_text [_ "dotlrn.control_panel"] \
	-pre_html "$extra_spaces" \
	-post_html $extra_spaces \
        -link_all $link_all
    ]
} else {
    set navbar "<br>"
}

# Set up some basic stuff
set user_id [ad_get_user_id]
set user_name "[dotlrn::get_user_name $user_id]"

if {![exists_and_not_null title]} {
    set title ".LRN"
}

if {[empty_string_p [dotlrn_community::get_parent_community_id -package_id [ad_conn package_id]]]} {
    set parent_comm_p 0
} else {
    set parent_comm_p 1
}

set community_id [dotlrn_community::get_community_id]

if {![empty_string_p $community_id]} {
    # in a community or just under one in a mounted package like /calendar 
    set comm_type [dotlrn_community::get_community_type_from_community_id $community_id]

    if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
	#The colors for a subgroup are set by the parent group with a few overwritten.
	set comm_type [dotlrn_community::get_community_type_from_community_id [dotlrn_community::get_parent_id -community_id $community_id]]
    }

    if {$comm_type == "dotlrn_club"} {
	    #community colors
	    set scope_name "comm"
	    set scope_main_color "#CC6633"
	    set scope_header_color "#F48F5C"
	    set scope_z_dark "#FFDDB0"
	    set scope_z_light "#FFF2E2"
	    set scope_light_border "#E7B59C"
	if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
	    set scope_z_dark "#FFDDB0"
	    set scope_z_light "#FFF2E2"
	}
    } else {
	set scope_name "course"
	set scope_main_color "#6C9A83"
	set scope_header_color $scope_main_color
	set scope_z_dark "#CDDED5"
	set scope_z_light "#E6EEEA"
	set scope_light_border "#D0DFD9"
	if {[dotlrn_community::subcommunity_p -community_id $community_id]} {
	    set scope_z_dark "#D0DFD9"
	    set scope_z_light "#ECF3F0"
	}
    }
  
    # DRB: default logo for dotlrn is a JPEG provided by Collaboraid.  This can
    # be replaced by custom gifs if prefered (as is done by SloanSpace)

    if { [file exists "$header_img_file-$scope_name.jpg"] } {
        set header_img_url "$header_img_url-$scope_name.jpg"
    } elseif { [file exists "$header_img_file-$scope_name.gif"] } {
        set header_img_url "$header_img_url-$scope_name.gif"
    }
  
   # set header_img_url "$header_img_url-$scope_name.gif"

   # font hack
   set community_header_font [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_font
    ]

    if {![empty_string_p $community_header_font]} {
	set header_font "$community_header_font,$header_font"
    }


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

	# Need filename
        set header_img_url "[dotlrn_community::get_community_url $community_id]/file-storage/download/?version_id=$header_logo_item_id" 
    }
	
   
    set header_logo_alt_text [dotlrn_community::get_attribute \
        -community_id $community_id \
        -attribute_name header_logo_alt_text
    ]

    if {![empty_string_p $header_logo_alt_text]} {
        set header_img_alt_text $header_logo_alt_text
    } 

    set text [dotlrn::user_context_bar -community_id $community_id]

    if { [string equal [ad_conn package_key] [dotlrn::package_key]] } {
        set text "<span class=\"header-text\">$text</span>"
    }

} elseif {[parameter::get -parameter community_type_level_p] == 1} {
    # in a community type (subject)
    set text \
            [dotlrn_community::get_community_type_name [dotlrn_community::get_community_type]]
} else {
    # under /dotlrn

    # DRB: default logo for dotlrn is a JPEG provided by Collaboraid.  This can
    # be replaced by custom gifs if prefered (as is done by SloanSpace)

    if { [file exists "$header_img_file-$scope_name.jpg"] } {
        set header_img_url "$header_img_url-$scope_name.jpg"
    } elseif { [file exists "$header_img_file-$scope_name.gif"] } {
        set header_img_url "$header_img_url-$scope_name.gif"
    }

    set text ""
}

if { ![info exists header_stuff] } {
    set header_stuff ""
}

# This style sheet should be moved over to an external file for performance
append header_stuff "
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">


<STYLE TYPE=\"text/css\">
BODY {
    FONT-WEIGHT: normal; 
    FONT-SIZE: small; 
    BACKGROUND: white; 
    COLOR: black; 
    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
}

H2 {
   FONT-FAMILY: Arial, Helvetica, sans-serif;
   FONT-SIZE: medium;
   FONT-WEIGHT: bold;
}

H3 {
   FONT-FAMILY: Arial, Helvetica, sans-serif;
   FONT-SIZE: small;
   COLOR: $scope_main_color; 
   FONT-WEIGHT: bold;
   MARGIN-BOTTOM: 0px;
}


H2.portal-page-name {
    FONT-WEIGHT: bold; FONT-SIZE: medium; COLOR: black; FONT-FAMILY: Arial, Helvetica, sans-serif; margin-top: 5px; margin-left: 5px;
}

TD.dark-line {
    font-size: 1px;
    background-color: $scope_main_color;
}

TD.light-line {
    font-size: 1px;
    background-color: $scope_light_border;
}

A {
    COLOR: #003399;
	
}
A:visited {
    COLOR: #666666;
}

UL {
    MARGIN-TOP: 0px;
}
UL UL LI {
    LIST-STYLE-IMAGE: url(/dotlrn/resources/dash.gif);
}
SMALL {
    FONT-SIZE: xsmall;
}
IMG.header-img {
    BACKGROUND: white; 
    COLOR: white;
}
.header-logo {
    BACKGROUND: white; 
    WIDTH: 100px; 
    COLOR: white;
    PADDING-RIGHT: 35px;
    PADDING-BOTTOM: 10px;
}
.header-text {
    FONT-SIZE: $header_font_size; 
    BACKGROUND: white; 
    WIDTH: 100px; 
    COLOR: $header_font_color; 
    FONT-FAMILY: $header_font;
    WHITE-SPACE: nowrap;
    font-weight: bold;
}

.element-header-text {
    FONT-SIZE: small; 
    font-weight:bold; 
    BACKGROUND: white;
    FONT-FAMILY: Arial, Helvetica, sans-serif;
    font-WEIGHT: bold; 
    COLOR: $scope_main_color; 
    text-transform: uppercase;
}

TD.element-text {
    FONT-SIZE: small; 
    BACKGROUND: white; 
    FONT-FAMILY: Arial, Helvetica, sans-serif;
}
TH.element-text {
    BACKGROUND: white; 
    FONT-SIZE: small; 
    FONT-FAMILY: Arial, Helvetica, sans-serif; 
}
TD.element-header-buttons {
    BACKGROUND: white; 
    COLOR: $scope_main_color; 
    WHITE-SPACE: nowrap;
}
IMG.element-header-button {
    BACKGROUND: $scope_main_color; 
    COLOR: $scope_main_color;
}

TR.table-header {
    BACKGROUND: $scope_header_color;
    FONT-SIZE: small;
    FONT-FAMILY: Arial, Helvetica, sans-serif; 
}

STRONG.table-header {
    BACKGROUND: $scope_header_color; 
    COLOR: $scope_highlight_text; 
    FONT-FAMILY: Arial, Helvetica, sans-serif; 
    FONT-SIZE: small;
}

TD.selected {
    BACKGROUND: $scope_main_color; 
    COLOR: $scope_highlight_text; 
    FONT-FAMILY: Arial, Helvetica, sans-serif; 
    font-weight: bold;
    BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none;
}

TABLE.element-content {
	padding-top: 5px; padding-right: 5px; padding-bottom: 5px; padding-left: 5px
}

TABLE.z_light {
    BACKGROUND: $scope_z_light;
}

TABLE.z_dark {
    BACKGROUND: $scope_z_dark;
}

TR.even {
    BACKGROUND: $scope_z_light;
}

TR.odd {
    BACKGROUND: $scope_z_dark;
}

HR.main_color {
    COLOR: $scope_main_color;
}

TR.table-title {
    BACKGROUND: $scope_z_dark;
}

TD.cal-week {
    BACKGROUND: $scope_z_light;
    VALIGN: top;
}

TD.cal-week-event {
    BACKGROUND: $scope_z_dark;
}

TD.cal-month-day {
    BACKGROUND: $scope_z_dark;
   BORDER: 1px c0c0c0 solid; padding-top: 1px; padding-right: 1px; padding-bottom: 1px; padding-left: 1px ;
}

TD.cal-month-today {
    BACKGROUND: $scope_z_light;
    BORDER-RIGHT: grey 1px solid; BORDER-TOP: grey 1px solid; BORDER-LEFT: grey 1px solid; BORDER-BOTTOM: grey 1px solid;
}

.element {
    BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none;
}

.no-border {
    BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none;
}

.footer {
    FONT-SIZE: x-small;
}
.navbar A {
    COLOR: $scope_main_color; 
    TEXT-DECORATION: none; 
    text-weight: bold;
}

.navbar A:visited {
    COLOR: $scope_main_color; 
    TEXT-DECORATION: none; 
    text-weight: bold;
}

TD.navbar {
    COLOR: $scope_main_color; 
    TEXT-DECORATION: none; 
    font-weight: bold;
    padding-top: 7px; padding-bottom:7px;
    FONT-FAMILY: Arial, Helvetica, sans-serif; 
    text-align: center; 
    FONT-SIZE: x-small;
}

TD.navbar-selected {
    background-color: $scope_main_color; 
    COLOR: $scope_highlight_text; 
    FONT-FAMILY: Arial, Helvetica, sans-serif; 
    FONT-SIZE: x-small; 
    text-align: center; 
    font-weight: bold;
    TEXT-DECORATION: none; 
    padding-top: 7px; padding-bottom:7px;
}

TABLE.table-display {
    BORDER-RIGHT: $scope_main_color 1px solid; BORDER-TOP: $scope_main_color 1px solid; BORDER-LEFT: $scope_main_color 1px solid; BORDER-BOTTOM: $scope_main_color 1px solid;
}

TABLE.portlet-config {
    BACKGROUND: white;
    CELLPADDING:5px;
    CELLSPACING: 5px;
}

TABLE.portal-page-config {
    BACKGROUND: $scope_z_dark;
    WIDTH: 700px;
    CELLPADDING: 5;
}


TD.bottom-border {
    BORDER-Bottom: $scope_main_color 1px solid;
}

TR.bottom-border {
    BORDER-Bottom: $scope_main_color 1px solid;
}

TD.center {
    ALIGN: center;
}


</STYLE>

"

# Focus
multirow create attribute key value

if { ![template::util::is_nil focus] } {
    # Handle elements wohse name contains a dot
    regexp {^([^.]*)\.(.*)$} $focus match form_name element_name
    
    template::multirow append \
            attribute onload "javascript:document.forms\['${form_name}'\].elements\['${element_name}'\].focus()"
}

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

set change_locale_url "/acs-lang/?[export_vars { { package_id "[ad_conn package_id]" } }]"
