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

ad_page_contract {

    Edit the properties for a community

    @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
    @creation-date 2002-05-20
    @version $Id$

} -query {
    {referer "one-community-admin"}
}

set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]
dotlrn::require_user_admin_community -user_id $user_id -community_id $community_id
set description [dotlrn_community::get_community_description -community_id $community_id]
set pretty_name [dotlrn_community::get_community_name $community_id]

form create edit_community_info

element create edit_community_info pretty_name \
    -label [_ dotlrn.Name] \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $pretty_name

element create edit_community_info description \
    -label [_ dotlrn.Description] \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -value $description \
    -optional

if {[form is_valid edit_community_info]} {
    form get_values edit_community_info pretty_name description
    
    dotlrn_community::set_community_name \
        -community_id $community_id \
        -pretty_name $pretty_name

    dotlrn_community::set_community_description \
        -community_id $community_id \
        -description $description

    ad_returnredirect $referer
    ad_script_abort
}

set roles [dotlrn_community::get_roles -community_id $community_id]

form create edit_community_role_names

foreach {rel_type role pretty_name pretty_plural} [eval concat $roles] {
    element create edit_community_role_names "${role}_pretty_name" \
        -label "$role [_ dotlrn.Pretty_Name]" \
        -datatype text \
        -widget text \
        -html {size 40} \
        -value $pretty_name

    element create edit_community_role_names "${role}_pretty_plural" \
        -label "$role [_ dotlrn.Pretty_Plural]" \
        -datatype text \
        -widget text \
        -html {size 40} \
        -value $pretty_plural
}

if {[form is_valid edit_community_role_names]} {
    set new_roles [list]

    foreach {rel_type role pretty_name pretty_plural} [eval concat $roles] {
        lappend new_roles [list \
            $rel_type \
            $role \
            [element get_value edit_community_role_names "${role}_pretty_name"] \
            [element get_value edit_community_role_names "${role}_pretty_plural"] \
        ]
    }

    dotlrn_community::set_roles_pretty_data \
        -community_id $community_id \
        -roles_data $new_roles

    ad_returnredirect $referer
    ad_script_abort
}

# set up some defaults and get attrs
set header_font [dotlrn_community::get_attribute \
    -community_id $community_id \
    -attribute_name header_font
]

set header_font_size [dotlrn_community::get_attribute \
    -community_id $community_id \
    -attribute_name header_font_size
]

set size_list [list medium small large x-large]
set pretty_size_list [list [_ dotlrn.Normal] [_ dotlrn.Small] [_ dotlrn.Large] [_ dotlrn.Extra_Large]]
set size_option_list [ad_generic_optionlist $pretty_size_list $size_list $header_font_size]

set header_font_color [dotlrn_community::get_attribute \
    -community_id $community_id \
    -attribute_name header_font_color
]

set header_alt_text [dotlrn_community::get_attribute \
    -community_id $community_id \
    -attribute_name header_logo_alt_text
]

set revision_id [dotlrn_community::get_attribute \
      -community_id $community_id \
      -attribute_name header_logo_item_id
  ]

# Default logos are served from known locations in the file system
# based on community type.

# Customized logos are stored in the public file-storage folder
# for the community.
 
if {[empty_string_p $revision_id]} {

    set comm_type [dotlrn_community::get_community_type_from_community_id $community_id]

    set temp_community_id $community_id
    while {[dotlrn_community::subcommunity_p -community_id $temp_community_id]} {
	# For a subcommunity, we use the logo of the
	# the first ancestor that is not a sub_community

	set temp_community_id [dotlrn_community::get_parent_id -community_id $temp_community_id]
	set comm_type [dotlrn_community::get_community_type_from_community_id $temp_community_id]
 
    }

    if {$comm_type == "dotlrn_club"} {
	#community colors
	set scope_name "comm"
    } else {
	set scope_name "course"
    }
    
    set header_url "[dotlrn::get_url]/resources/logo-$scope_name.gif"

} else {
    set header_url "[dotlrn_community::get_community_url $community_id]/file-storage/download/?version_id=$revision_id"
}
 
set title [_ dotlrn.Edit_Properties]
set context_bar [list [list one-community-admin [_ dotlrn.Administer]] [_ dotlrn.Edit_Properties]]

ad_return_template







