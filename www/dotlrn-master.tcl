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

ad_page_contract {

    Q: What is this file?

    A: This is the master template for dotlrn. It sets up the navbar and
    dynamically generates a CSS file for the dotlrn banner color, font, header 
    image, and the portal themes.

    Q: How do I get the dotlrn banner and navigation everywhere on my site, 
    not just under /dotlrn?

    A: By default the dotlrn banner and navigation is NOT shown everywhere on 
    your site. If you would like the dotlrn banner and navigation everywhere,
    Change the "Main Site"'s "DefaultMaster" parameter 
    from "/www/default-master" to "/packages/dotlrn/www/dotlrn-master"
    at http://yoursite.com/admin/site-map

    Q: How do I customize the banner, images, CSS, etc?

    A: You can change the default banner and generated CSS by editing this file
    and the associated ADP.

    WARNING: All current portlet themes (table, deco, nada, etc) depend on some
    of the CSS generated below. Be careful when you edit the CSS below otherwise
    these themes will most likely break.

    Q: I added some custom pages to /dotlrn. How do I control the navbar from
    these pages? 

    A: ADP pages can pass properties "up" to this script to alter it's behavior.

    The properties an ADP can set are:
    title - the html title
    no_navbar_p - if 1, hide navbar
    link_all - if exists, make all page names in the navbar links
    show_control_panel - if 1 show the "Control Panel" link in the navbar
    link_control_panel - if 1 link the "Control Panel" link in the navbar


    TODO:
    1. link_control_panel - are ADPs using this right?

    @author arjun (arjun@openforce.net)
    @version $Id$

} {
    {title "SloanSpace"}
    {no_navbar_p 0}
}

#     {link_all 0}
#     {show_control_panel 0}
#     {link_control_panel 1}

if {![info exists link_control_panel]} {
    set link_control_panel 1
}

if {![info exists show_control_panel]} {
    set show_control_panel 0
}

if {![info exists link_all]} {
    set link_all 0
}

#ad_return_complaint 1 "foo $link_control_panel / $title"
#ad_script_abort

#
# Set up some basic vars
# 
set user_id [ad_get_user_id] 
set portal_id ""
set full_name "[dotlrn::get_user_name $user_id]"
set control_panel_text "Control Panel"

# properties for the adp
set dotlrn_url [dotlrn::get_url]
set dotlrn_graphics_url "/graphics"
set text $full_name
set navbar "<br>"


#                    
# navbar generation
#
# All this code does is get the correct values for portal_id and sets some 
# navbar variables based on the user and location# 
# 

if {!$no_navbar_p} {
    
    set community_id [dotlrn_community::get_community_id]
    set control_panel_name preferences

    if {[empty_string_p $community_id]} {
        #
        # We are not under a dotlrn community. However we could be under /dotlrn
        # (i.e. in the user's portal) or anywhere else on the site
        #
        if {[dotlrn::user_p -user_id $user_id]} {
            # this user is a dotlrn user, show their personal portal
            # navbar, including the control panel link
            set portal_id [dotlrn::get_portal_id -user_id $user_id]
            set show_control_panel 1
        }
    } else {
        #
        # We are under a dotlrn community. Get the community's portal_id, etc.
        #
        
        # some defaults
        set text [dotlrn_community::get_community_header_name $community_id] 
        set control_panel_name one-community-admin
    
        # figure out what this privs this user has on the community
        set admin_p [dotlrn::user_can_admin_community_p \
            -user_id $user_id \
            -community_id $community_id
        ]
    
        if {!$admin_p} {
            # the user can't admin this community, perhaps they are a
            # humble member instead?
            set member_p [dotlrn_community::member_p $community_id $user_i]
        } else {
            # admins always get the control_panel_link
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

    # Common code for the the behavior of the "control panel" link
    #
    if {![string equal [ad_conn url] "[dotlrn::get_url]/" ]} {
        # if we are not under /dotlrn, link all of the pages in the navbar
        set link_all 1 
    } 

    if {$show_control_panel} {
        if {$link_control_panel} {
            set extra_td_html \
                " &nbsp; <a href=$control_panel_name>$control_panel_text</a>"
        } else {
            set extra_td_html " &nbsp; $control_panel_text"
        } 
    } else {
        set extra_td_html {}
    } 

    # Actually generate the navbar, if we got a valid portal_id
    
    if {![empty_string_p $portal_id]} {
        set navbar [portal::navbar \
            -portal_id $portal_id \
            -link_all $link_all \
            -link "$dotlrn_url/" \
            -pre_html "" \
            -post_html "" \
            -extra_td_html $extra_td_html \
            -table_html_args "class=\"navbar\""]
    }
}


# the ColorHack and FontHack and LogoHack!
set color_hack "#cc0000"
set color_hack_name "red"
set header_font ""
set header_font_size "medium"
set header_font_color "black"
set header_logo_item_id ""
set header_img_url "$dotlrn_graphics_url/logowhite.gif" 
set header_img_alt_text "Header Logo"


# gets the package_id for the passed in dotlrn instace,
# if the community_id is invalid, returns the pacakge_id of the 
# main dotlrn instance ???
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

#
# WARNING: All current portlet themes (table, deco, nada, etc) depend on some
# of the CSS defined below. Be carefull when you edit the CSS below, 
# and check how themes use it.
#

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

ad_return_template
