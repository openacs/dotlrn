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
    Replicate User Management Page

    @author yon (yon@openforce.net)
    @creation-date 2002-02-10
    @version $Id$
} -query {
    {type "any"}
    {can_browse_p "any"}
    {guest_p "any"}
    {join_criteria "and"}
    {n_users 0}
    {action "none"}
} -properties {
    context_bar:onevalue
    is_request:onevalue
    n_users:onevalue
}

set context_bar [list [list users [_ dotlrn.Users]] [_ dotlrn.User_Search]]

set package_id [ad_conn package_id]

form create user_search_results

element create user_search_results selected_users \
    -label "&nbsp;" \
    -datatype text \
    -widget checkbox

element create user_search_results search_action \
    -label "[_ dotlrn.Action]" \
    -datatype text \
    -widget radio \
    -options [list \
        [list [_ dotlrn.None] none] \
        [list [_ dotlrn.Spam_] spam] \
        [list [_ dotlrn.Add_to_group_] add_to_community] \
        [list [_ dotlrn.Deactivate_] deactivate] \
        [list [_ dotlrn.Nuke_] delete] \
    ] \
    -value $action

if {[form is_valid user_search_results]} {
    form get_values user_search_results search_action

    set selected_users [element get_values user_search_results selected_users]

    switch -exact $search_action {
        "spam" {
            ad_returnredirect "users-spam?[export_vars {{users $selected_users}}]"
        }
        "add_to_community" {
            ad_returnredirect "users-add-to-community?[export_vars {{users $selected_users}}]"
        }
        "deactivate" {
            ad_returnredirect "users-deactivate?[export_vars {{users $selected_users}}]"
        }
        "delete" {
            ad_returnredirect "users-delete?[export_vars {{users $selected_users}}]"
        }
    }
}

form create user_search

element create user_search name \
    -label "[_ dotlrn.Name__Email]" \
    -datatype text \
    -widget text \
    -html {size 30} \
    -optional

element create user_search id \
    -label "[_ dotlrn.ID_1]" \
    -datatype text \
    -widget text \
    -html {size 10} \
    -optional

element create user_search type \
    -label "[_ dotlrn.Type]" \
    -datatype text \
    -widget select \
    -options "[list [_ dotlrn.Any] any] [dotlrn::get_user_types_as_options]" \
    -value $type

element create user_search can_browse_p \
    -label "[_ dotlrn.Access_Level]" \
    -datatype text \
    -widget select \
    -options [list [list [_ dotlrn.Any] any] [list [_ dotlrn.Limited] 0] [list [_ dotlrn.Full] 1]] \
    -value $can_browse_p

element create user_search guest_p \
    -label "[_ dotlrn.Guest_1]" \
    -datatype text \
    -widget select \
    -options [list [list [_ dotlrn.Any] any] [list [_ dotlrn.Yes] t] [list [_ dotlrn.No] f]] \
    -value $guest_p

element create user_search role \
    -label "[_ dotlrn.Role]" \
    -datatype text \
    -widget checkbox \
    -options [dotlrn_community::get_all_roles_as_options] \
    -optional

element create user_search last_visit_greater \
    -label "[_ dotlrn.lt_Last_Visit_Over_in_da]" \
    -datatype text \
    -widget text \
    -html {size 10} \
    -optional

element create user_search last_visit_less \
    -label "[_ dotlrn.lt_Last_Visit_Within_in_]" \
    -datatype text \
    -widget text \
    -html {size 10} \
    -optional

element create user_search join_criteria \
    -label "[_ dotlrn.lt_Join_the_above_criter_1]" \
    -datatype text \
    -widget select \
    -options [list [list [_ dotlrn.And] and] [list [_ dotlrn.Or] or]] \
    -value $join_criteria

set is_request [form is_request user_search]

if {[form is_valid user_search]} {
    form get_values user_search \
        id type can_browse_p guest_p last_visit_greater last_visit_less name join_criteria

    if {([string equal "and" $join_criteria] == 0) && ([string equal "or" $join_criteria] == 0)} {
        ad_return_error \
            "[_ dotlrn.lt_There_was_a_bug_in_th]" \
            "[_ dotlrn.lt_There_was_a_bug_in_th_1]"
    }

    set context_bar [list [list users [_ dotlrn.Users]] [list users-search [_ dotlrn.User_Search]] [_ dotlrn.Results]]

    set tables [list "dotlrn_users"]
    set cols [list \
        "distinct dotlrn_users.user_id" \
        "dotlrn_users.id" \
        "dotlrn_users.first_names" \
        "dotlrn_users.last_name" \
        "dotlrn_users.email" \
        "dotlrn_users.type" \
    ]
    set wheres [list]

    if {![empty_string_p $name]} {
        lappend wheres "(lower(dotlrn_users.last_name) like lower('%' || :name || '%') or lower(dotlrn_users.first_names) like lower('%' || :name || '%') or lower(dotlrn_users.email) like lower('%' || :name || '%'))"
    }

    if {![empty_string_p $id]} {
        lappend wheres "(lower(dotlrn_users.id) like lower('%' || :id || '%'))"
    }

    if {![empty_string_p $type]} {
        if {[string equal "any" $type] == 1} {
            lappend wheres "dotlrn_users.type in (\'[join [dotlrn::get_user_types] \',\']\')"
        } else {
            lappend wheres "dotlrn_users.type = :type"
        }
    }

    switch -exact $can_browse_p {
        any {}
        1 {
            lappend wheres "exists (select 1 from acs_permissions where object_id = :package_id and grantee_id = dotlrn_users.user_id and privilege = 'dotlrn_browse')"
        }
        0 {
            lappend wheres "not exists (select 1 from acs_permissions where object_id = :package_id and grantee_id = dotlrn_users.user_id and privilege = 'dotlrn_browse')"
        }
    }

    switch -exact $guest_p {
        any {}
        t {
            lappend wheres "exists (select 1 from dotlrn_guest_status where dotlrn_guest_status.user_id = dotlrn_users.user_id and guest_p = 't')"
        }
        f {
            lappend wheres "exists (select 1 from dotlrn_guest_status where dotlrn_guest_status.user_id = dotlrn_users.user_id and guest_p = 'f')"
        }
    }

    if {![empty_string_p $last_visit_greater]} {
        if {[lsearch -exact $tables "users"] == -1} {
            lappend tables "users"
        }
        lappend wheres "(dotlrn_users.user_id = users.user_id and users.last_visit <= (sysdate - :last_visit_greater))"
    }

    if {![empty_string_p $last_visit_less]} {
        if {[lsearch -exact $tables "users"] == -1} {
            lappend tables "users"
        }
        lappend wheres "(dotlrn_users.user_id = users.user_id and users.last_visit >= (sysdate - :last_visit_less))"
    }

    set role_list [element get_values user_search role]
    set role_list_length [llength $role_list]

    if {$role_list_length} {
        if {[lsearch -exact $tables "acs_rels"] == -1} {
            lappend tables "acs_rels"
        }
        set in_clause "(dotlrn_users.user_id = acs_rels.object_id_two and acs_rels.rel_type in ("

        set in_elements [list]
        for {set i 0} {$i < $role_list_length} {incr i} {
            set in_element__${i} [lindex $role_list $i]
            lappend in_elements ":in_element__${i}"
        }

        append in_clause [join $in_elements ", "]
        append in_clause "))"

        lappend wheres $in_clause
    }

    set sql "select "
    append sql [join $cols ", "]

    append sql " from "
    append sql [join $tables ", "]

    if {[llength $wheres]} {
        append sql " where "
        append sql [join $wheres " $join_criteria "]
	append sql "order by last_name, first_names"
    }

    set referer [ns_conn url]
    set selected_users_options [list]
    set selected_users_values [list]
    db_foreach select_users $sql {
        lappend selected_users_options [list "<a href=\"user?[export_vars user_id]\">$last_name, $first_names</a> ($email)" $user_id]
        lappend selected_users_values $user_id
    }

    element set_properties user_search_results selected_users \
        -options $selected_users_options \
        -values $selected_users_values

    set n_users [llength $selected_users_values]
}

ad_return_template

