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


# the ColorHack!
set color_hack "#cc0000"
set color_hack_name "red"

if {[empty_string_p [dotlrn_community::get_parent_community_id -package_id [ad_conn package_id]]]} {
    set parent_comm_p 0
} else {
    set parent_comm_p 1
}

# in a community or just under one in a mounted package like /calendar 
if {[ad_parameter community_level_p] == 1 || $parent_comm_p } {
    set community_id [dotlrn_community::get_community_id]
    
    # aks color hack
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

    # The header text is the name of the community
    set text [dotlrn_community::get_community_header_name $community_id] 

} elseif {[ad_parameter community_type_level_p] == 1} {
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

LI {
    list-style-type: circle;
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

