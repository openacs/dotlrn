ad_page_contract {
    Change the join policy of a dotLRN community.

    @author yon (yon@openforce.net)
    @creation-date 2002-01-18
    @version $Id$
} -query {
    {community_id ""}
    policy:notnull
    {referer "one-community-admin"}
} -validate {
    policy_ck -requires {policy:notnull} {
        if {!(
            [string equal $policy "open"] == 1 ||
            [string equal $policy "needs approval"] == 1 ||
            [string equal $policy "closed"] == 1
        )} {
            ad_complain {policy must be one of: open, needs approval, or closed}
        }
    }
}

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_admin_community $community_id

db_dml update_join_policy {}

ad_returnredirect $referer
