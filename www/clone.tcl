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
    clone a community

    @author arjun (arjun@openforce.net)
    @version $Id$
} -query {
    {referer "one-community-admin"}
} -properties {
    title:onevalue
}

set user_id [ad_get_user_id]
set community_id [dotlrn_community::get_community_id]

# this page must be restricted to admins of the community only
dotlrn::require_user_admin_community \
    -user_id $user_id \
    -community_id $community_id

set class_instance_p 0
set community_name [dotlrn_community::get_community_name $community_id]
set title "Copy $community_name"
set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
set top_community_type [dotlrn_community::get_toplevel_community_type_from_community_id $community_id]

if { $top_community_type != "dotlrn_club" 
     && $top_community_type != "dotlrn_community" } {

    set class_instance_p 1
    set term_id [dotlrn_class::get_term_id -class_instance_id $community_id]
}


form create clone_form

# generate the clone's key, with collision resolution here
set key [dotlrn::generate_key -increment -name $community_name]

while {![dotlrn_community::check_community_key_valid_p -community_key $key]} {
    set key [dotlrn::generate_key -increment -name $key]
}

if {$class_instance_p} {
    element create clone_form term \
        -label Term \
        -datatype integer \
        -widget select \
        -options [dotlrn_term::get_future_terms_as_options] 
}

element create clone_form pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 40} \
    -value $key

element create clone_form description \
    -label Description \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional \
    -value "A copy of $community_name"

element create clone_form referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid clone_form]} {
    
    set term ""

    if {!$class_instance_p} {
        form get_values clone_form pretty_name description referer 
    } else {
        form get_values clone_form pretty_name description referer term
    }

    set clone_id [dotlrn_community::clone \
                      -community_id $community_id \
                      -key $key \
                      -pretty_name $pretty_name \
                      -description $description \
                      -term_id $term
    ]
    set url [dotlrn_community::get_community_url $clone_id]
    ad_returnredirect "$url/one-community-admin"

    ad_script_abort
}

ad_return_template
