# dotlrn/www/admin/new-users.tcl

ad_page_contract {
    Replicate Sloanspace User Management Page

    @author yon (yon@openforce.net)
    @creation-date 2002-02-10
    @version $Id$
} -query {
    {type "any"}
    {access_level "any"}
    {private_data_p "any"}
    {join_criteria "and"}
    {n_users 0}
    {action "none"}
} -properties {
    context_bar:onevalue
    is_request:onevalue
    n_users:onevalue
}

set context_bar {{users Users} {User Search}}

set package_id [ad_conn package_id]

form create user_search_results

element create user_search_results selected_users \
    -label "&nbsp;" \
    -datatype text \
    -widget checkbox

element create user_search_results action \
    -label "Action" \
    -datatype text \
    -widget radio \
    -options {
        {None none}
        {{Spam ...} spam}
        {{Add to community ...} add_to_community}
        {{Deactivate ...} deactivate}
        {{Nuke ...} delete}
    } \
    -value $action

if {[form is_valid user_search_results]} {
    form get_values user_search_results action

    set selected_users [element get_values user_search_results selected_users]

    switch -exact $action {
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
    -label "Name / Email" \
    -datatype text \
    -widget text \
    -html {size 30} \
    -optional

element create user_search id \
    -label "ID" \
    -datatype text \
    -widget text \
    -html {size 10} \
    -optional

element create user_search type \
    -label "Type" \
    -datatype text \
    -widget radio \
    -options "{Any any} [dotlrn::get_user_types_as_options]" \
    -value $type

element create user_search access_level \
    -label "Access Level" \
    -datatype text \
    -widget radio \
    -options {{Any any} {Limited limited} {Full full}} \
    -value $access_level

element create user_search private_data_p \
    -label "Guest?" \
    -datatype text \
    -widget radio \
    -options {{Any any} {Yes f} {No t}} \
    -value $private_data_p

element create user_search role \
    -label "Role" \
    -datatype text \
    -widget checkbox \
    -options [dotlrn_community::get_all_roles_as_options] \
    -optional

element create user_search last_visit_greater \
    -label "Last Visit Over (in days)" \
    -datatype text \
    -widget text \
    -html {size 10} \
    -optional

element create user_search last_visit_less \
    -label "Last Visit Within (in days)" \
    -datatype text \
    -widget text \
    -html {size 10} \
    -optional

element create user_search join_criteria \
    -label "Join the above criteria by" \
    -datatype text \
    -widget radio \
    -options {{And and} {Or or}} \
    -value $join_criteria

set is_request [form is_request user_search]

if {[form is_valid user_search]} {
    form get_values user_search \
        id type access_level private_data_p last_visit_greater last_visit_less name join_criteria

    if {([string equal "and" $join_criteria] == 0) && ([string equal "or" $join_criteria] == 0)} {
        ad_return_error \
            "There was a bug in this page" \
            "There was a bug in this page. Please report this problem."
    }

    set context_bar {{users Users} {users-search {User Search}} {Results}}

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
        lappend wheres "dotlrn_users.id = :id"
    }

    if {![empty_string_p $type]} {
        if {[string equal "any" $type] == 1} {
            lappend wheres "dotlrn_users.type in (\'[join [dotlrn::get_user_types] \',\']\')"
        } else {
            lappend wheres "dotlrn_users.type = :type"
        }
    }

    switch -exact $access_level {
        "full" {
            lappend wheres "exists (select 1 from dotlrn_full_users where dotlrn_full_users.rel_id = dotlrn_users.rel_id)"
        }
        "limited" {
            lappend wheres "not exists (select 1 from dotlrn_full_users where dotlrn_full_users.rel_id = dotlrn_users.rel_id)"
        }
    }

    switch -exact $private_data_p {
        any {}
        default {
            lappend wheres ":private_data_p = acs_permission.permission_p(:package_id, dotlrn_users.user_id, 'read_private_data')"
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
    }

    set referer "users-search"
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
