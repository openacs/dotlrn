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

# dotlrn/www/members-chunk-table.tcl

ad_page_contract {
    @author arjun (arjun@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2002-01-08
    @version $Id$
}  -query {
    {parent_user_role:multiple,array,optional}
    {order "last_name"}
    {order_direction "asc"}
} -properties {
    users:multirow
    n_parent_users:onevalue
}

set dotlrn_url [dotlrn::get_url]

# use my_user_id here so we don't confuse with user_id from the query
set my_user_id [ad_conn user_id]

dotlrn::require_user_read_private_data -user_id $my_user_id

set community_id [dotlrn_community::get_community_id]
set referer [ns_conn url]

set site_wide_admin_p [permission::permission_p \
    -object_id [acs_magic_object security_context_root] \
    -privilege admin \
]

if {!$site_wide_admin_p} {
    set admin_p [dotlrn::user_can_admin_community_p -user_id $my_user_id -community_id $community_id]
    set read_private_data_p [dotlrn::user_can_read_private_data_p -user_id $my_user_id]
} else {
    set admin_p 1
    set read_private_data_p 1
}

if {![exists_and_not_null referer]} {
    if {[string equal $admin_p t] == 1} {
        set referer "one-community-admin"
    } else {
        set referer "one-community"
    }
}


if {[string compare $order_direction "asc"]==0} {
    set order_html "<img src=\"/resources/dotlrn/down.gif\" height=15 width=15>"
    set opposite_order_direction "desc"
} else {
    set order_html "<img src=\"/resources/dotlrn/up.gif\" height=15 width=15>"
    set opposite_order_direction "asc"
}

# Variables that will be used if the column
# is not selected.

set first_names_order_html ""
set last_name_order_html ""
set email_order_html ""

set first_names_order_direction $order_direction
set last_name_order_direction $order_direction
set email_order_direction $order_direction

# Special case for the selected column.
switch $order {
    "first_names" {
	set first_names_order_html $order_html
	set first_names_order_direction $opposite_order_direction
    }
    "last_name"  {
	set last_name_order_html $order_html
	set last_name_order_direction $opposite_order_direction
    }
    "email"  {
	set email_order_html $order_html
	set email_order_direction $opposite_order_direction
    }
}

# vars to carry over (from previous script)
# Do a special clause for role!

# The note in the members-chunk-table.xql indicated that
# it would be very hard to make sorting work with ad_table
# and sorting by columns functionality was incomplete.  After 
# struggling with ad_table for a while, I went to the
# OpenACS IRC and asked some questions.  The response
# basically was that ad_table needs a refactoring.
# Therefore, I (teadams@alum.mit.edu) decided to 
# simplify and use db_multirow and code my own column
# sorting.  

set order_by "$order $order_direction"

db_multirow current_members select_current_members {}

db_multirow pending_users select_pending_users {
    select dotlrn_users.*,
           dotlrn_member_rels_full.rel_type,
           dotlrn_member_rels_full.role
    from dotlrn_users,
         dotlrn_member_rels_full
    where dotlrn_users.user_id = dotlrn_member_rels_full.user_id
    and dotlrn_member_rels_full.community_id = :community_id
    and dotlrn_member_rels_full.member_state = 'needs approval'
} {
    set role [dotlrn_community::get_role_pretty_name -community_id $community_id -rel_type $rel_type]
}

# If we are in a subcomm. get the list of the users of the parent
# comm that are not in the subcomm yet, and output them with radios
# for roles, etc.
set subcomm_p [dotlrn_community::subcommunity_p -community_id $community_id]

if {$subcomm_p} {

    form create parent_users_form

    set parent_user_list [dotlrn_community::list_possible_subcomm_users -subcomm_id $community_id]
    set n_parent_users [llength $parent_user_list]

    foreach user $parent_user_list {
        element create parent_users_form "selected_user.[ns_set get $user user_id]" \
            -datatype text \
            -widget radio \
            -options {{{} none} {{} dotlrn_member_rel} {{} dotlrn_admin_rel}} \
            -value none
    }

    if {[form is_valid parent_users_form]} {

        foreach user $parent_user_list {
            set rel [element get_value parent_users_form "selected_user.[ns_set get $user user_id]"]

            if {![string match $rel none]} {
                dotlrn_community::add_user -rel_type $rel $community_id [ns_set get $user user_id]
            }
        }

        ad_returnredirect [ns_conn url]
    }

}

ad_return_template

