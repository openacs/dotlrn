ad_page_contract {
    Displays the admin users page

    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {type "admin"}
} -properties {
    context_bar:onevalue
    control_bar:onevalue
    n_users:onevalue
}

set context_bar {Users}

set dotlrn_roles [db_list_of_lists select_dotlrn_roles {
    select dotlrn_user_types.type,
           dotlrn_user_types.pretty_name || ' (' || (select count(*)
                                                     from party_member_map
                                                     where party_member_map.party_id = dotlrn_user_types.group_id
                                                     and party_member_map.member_id <> dotlrn_user_types.group_id) || ')',
           ''
    from dotlrn_user_types
    order by dotlrn_user_types.pretty_name
}]

set n_pending_users [db_string select_non_dotlrn_users_count {}]
lappend dotlrn_roles [list pending "Pending ($n_pending_users)" {}]

set n_deactivated_users [db_string select_deactivated_users_count {}]
lappend dotlrn_roles [list deactivated "Deactivated ($n_deactivated_users)" {}]

set control_bar [ad_dimensional [list [list type {User Type:} admin $dotlrn_roles]]]

if {[string equal $type "deactivated"] == 1} {
    set n_users $n_deactivated_users
} elseif {[string equal $type "pending"] == 1} {
    set n_users $n_pending_users
} else {
    set n_users [db_string select_dotlrn_users_count {}]
}

ad_return_template
