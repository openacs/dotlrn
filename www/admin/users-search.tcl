# dotlrn/www/admin/new-users.tcl

ad_page_contract {
    Replicate Sloanspace User Management Page

    @author yon (yon@openforce.net)
    @creation-date 2002-02-10
    @version $Id$
} -query {
    {type "any"}
    {join_criteria "and"}
    {n_users 0}
} -properties {
    context_bar:onevalue
    is_request:onevalue
    n_users:onevalue
}

set context_bar {{users Users} {User Search}}

form create user_search_results

element create user_search_results selected_users \
    -label "&nbsp;" \
    -datatype text \
    -widget checkbox

set communities [db_list_of_lists select_all_communities {
    select pretty_name, community_id
    from dotlrn_communities
}]

if {[llength $communities]} {
    element create user_search_results community_id \
        -label "Add to" \
        -datatype text \
        -widget select \
        -options "{{} {}} $communities"
} else {
    element create user_search_results community_id \
        -label "No communities to add to" \
        -datatype text \
        -widget hidden \
        -value ""
}

if {[form is_valid user_search_results]} {
    form get_values user_search_results community_id

    set selected_users [element get_values user_search_results selected_users]

    if {![empty_string_p $community_id]} {
        db_transaction {
            foreach selected_user $selected_users {
                dotlrn_community::add_user $community_id $selected_user
            }
        }
    }
}

form create user_search

element create user_search id \
    -label "ID" \
    -datatype text \
    -widget text \
    -html {size 30} \
    -optional

element create user_search type \
    -label "Type" \
    -datatype text \
    -widget radio \
    -options "{Any any} [dotlrn::get_user_types_as_options]" \
    -value $type

element create user_search role \
    -label "Role" \
    -datatype text \
    -widget checkbox \
    -options [dotlrn_community::get_all_roles_as_options] \
    -optional

element create user_search last_name \
    -label "Last name starts with" \
    -datatype text \
    -widget text \
    -html {size 60} \
    -optional

element create user_search email \
    -label "Email starts with" \
    -datatype text \
    -widget text \
    -html {size 60} \
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
        id type last_name email join_criteria

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

    if {![empty_string_p $last_name]} {
        lappend wheres "lower(dotlrn_users.last_name) like lower(:last_name || '%')"
    }

    if {![empty_string_p $email]} {
        lappend wheres "lower(dotlrn_users.email) like lower(:email || '%')"
    }

    set role_list [element get_values user_search role]
    set role_list_length [llength $role_list]

    if {$role_list_length} {
        lappend tables "acs_rels"
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
        lappend selected_users_options [list "<a href=\"user-edit?[export_vars {user_id referer}]\">$last_name, $first_names</a> ($email)" $user_id]
        lappend selected_users_values $user_id
    }

    element set_properties user_search_results selected_users \
        -options $selected_users_options \
        -values $selected_users_values

    set n_users [llength $selected_users_values]
}

ad_return_template
