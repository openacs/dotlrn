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

# dotlrn/www/members-chunk-table.tcl

ad_page_contract {
    @author arjun (arjun@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date Jan 08, 2002
    @version $Id$
}  -query {
    {parent_user_role:multiple,array,optional}
    {orderby "role"}
} -properties {
    users:multirow
    n_parent_users:onevalue
}

# use my_user_id here so we don't confuse with user_id from the query
set my_user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]
set referer [ns_conn url]

set site_wide_admin_p [ad_permission_p \
	-user_id $my_user_id \
	[acs_magic_object "security_context_root"] "admin"
]

if {!$site_wide_admin_p} {
    set admin_p [dotlrn::user_can_admin_community_p -user_id $my_user_id $community_id]
    set read_private_data_p [dotlrn::user_can_read_private_data_p $my_user_id]
} else {
    set admin_p 1
    set read_private_data_p 1
}

if {![exists_and_not_null referer]} {
    if {[string equal $admin_p "t"] == 1} {
        set referer "one-community-admin"
    } else {
        set referer "one-community"
    }
}

# Get all users for this community, including role
set community_members [dotlrn_community::list_users $community_id]

set table_def [list]
lappend table_def [list \
	first_names \
	"First Names" \
	{upper(first_names) $order} \
	{<td>[acs_community_member_link -user_id $user_id -label $first_names</td>]}
]
lappend table_def [list \
	last_name \
	"Last Name" \
	{upper(last_name) $order} \
	{<td>[acs_community_member_link -user_id $user_id -label $last_name</td>]}
]

if {$read_private_data_p || [string equal $my_user_id $user_id]} {
    lappend table_def [list \
	    email \
	    "Email" \
	    {upper(email) $order, upper(role)} \
	    {<td><a href="mailto:$email">$email</a></td>}
]
} else {
    lappend table_def [list \
	    email \
	    "Email" \
	    {upper(email) $order, upper(role)} \
	    {<td>&nbsp;</td>}
]
}

lappend table_def [list \
	role \
	"Role" \
	{decode(role, 'Professor', 1, 
                      'Administrator', 2, 
                      'Teaching Assistant', 3, 
                      'Course Assistant', 4, 
                      'Course Administrator', 5, 
                      'Student', 6, 
                      'Member', 7) asc, last_name $order} \
        {<td><nobr>$role</nobr></td>}
]

if {$site_wide_admin_p} {
    lappend table_def [list \
	    manage \
	    "" \
	    {} \
	    {<td>\[<a href="deregister?user_id=$user_id&referer=$referer">Drop&nbsp;Membership</a>\]
             \[<a href=[dotlrn::get_url]/admin/user?user_id=$user_id>Manage</a>\]</td>}]
} elseif {$admin_p} {
    lappend table_def [list \
	    manage \
	    "" \
	    {} \
	    {<td>\[<a href="deregister?user_id=$user_id&referer=$referer">Drop&nbsp;Membership</a>\]}
]
} else {
    lappend table_def [list \
	    manage \
	    "" \
	    {} \
	    {[eval {if {$my_user_id == $user_id} {
	                return "<td>\[<a href=\"deregister?user_id=$user_id&referer=$referer\">Drop&nbsp;Membership</a>\]</td>"
                    } else {
	                return "<td>&nbsp;</td>"
                    }
                   }
	     ]
            }
]
}

set sql "
select dotlrn_member_rels_approved.rel_id,
       dotlrn_member_rels_approved.rel_type,
       dotlrn_member_rels_approved.role,
       dotlrn_member_rels_approved.user_id,
       registered_users.first_names,
       registered_users.last_name,
       registered_users.email
from registered_users,
     dotlrn_member_rels_approved
where dotlrn_member_rels_approved.community_id = :community_id
and dotlrn_member_rels_approved.user_id = registered_users.user_id
[ad_order_by_from_sort_spec $orderby $table_def]"

set table [ad_table \
	-Textra_vars {referer my_user_id} \
	-Torderby $orderby \
	make_table \
	$sql \
	$table_def
]

set user_list [list]
foreach user $community_members {
    lappend user_list [ns_set get $user user_id]
}

db_multirow pending_users select_pending_users {
    select dotlrn_users.*,
           dotlrn_member_rels_full.rel_type,
           dotlrn_member_rels_full.role
    from dotlrn_users,
         dotlrn_member_rels_full
    where dotlrn_users.user_id = dotlrn_member_rels_full.user_id
    and dotlrn_member_rels_full.community_id = :community_id
    and dotlrn_member_rels_full.member_state = 'needs approval'
}

# If we are in a subcomm. get the list of the users of the parent
# comm that are not in the subcomm yet, and output them with radios
# for roles, etc.
set subcomm_p [dotlrn_community::subcommunity_p -community_id $community_id]

if {$subcomm_p} {

    form create parent_users_form

    element create parent_users_form selected_users \
        -label "&nbsp;" \
        -datatype text \
        -widget checkbox \
        -optional

    set parent_user_list [dotlrn_community::list_possible_subcomm_users -subcomm_id $community_id]
    set n_parent_users [llength $parent_user_list]

    if {[form is_valid parent_users_form]} {
        set selected_users [element get_values parent_users_form selected_users]

        foreach selected_user $selected_users {
            dotlrn_community::add_user -rel_type $parent_user_role($selected_user) $community_id $selected_user
        }

        ad_returnredirect [ns_conn url]
    }

    set selected_users_options [list]

    foreach user $parent_user_list {
        lappend selected_users_options [list "<table width=\"100%\" border=\"0\"><tr><td width=\"15%\" align=\"center\"><input type=\"radio\" name=\"parent_user_role.[ns_set get $user user_id]\" value=\"dotlrn_member_rel\" checked></td><td width=\"15%\" align=\"center\"><input type=\"radio\" name=\"parent_user_role.[ns_set get $user user_id]\" value=\"dotlrn_admin_rel\"></td><td>[ns_set get $user last_name], [ns_set get $user first_names] ([ns_set get $user email])</td></tr></table>" [ns_set get $user user_id]]
    }

    element set_properties parent_users_form selected_users -options $selected_users_options

}

ad_return_template
