ad_page_contract {
    Manage the Applets for this community

    @author yon (yon@openforce.net)
    @creation-date 2002-01-19
    @version $Id$
} -query {
}

set community_id [dotlrn_community::get_community_id]
set user_id [ad_get_user_id]
set portal_id [dotlrn_community::get_portal_id $community_id $user_id]

set context_bar {{"one-community-admin" Admin} {Manage Applets}}
