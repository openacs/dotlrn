ad_page_contract {
    register

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-06
    @version $Id$
} -query {
    {user_id ""}
    {community_id ""}
    {referer "./"}
}

ad_maybe_redirect_for_registration

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

if {[empty_string_p $user_id]} {
    set user_id [ad_conn user_id]
} else {
    dotlrn::require_user_admin_community $community_id
}

set join_policy [db_string select_join_policy {
    select join_policy
    from dotlrn_communities_full
    where community_id = :community_id
}]

switch -exact $join_policy {
    "open" {
        dotlrn_community::add_user $community_id $user_id
    }
    "needs approval" {
        dotlrn_community::add_user -member_state "needs approval" $community_id $user_id
    }
}

ad_returnredirect $referer
