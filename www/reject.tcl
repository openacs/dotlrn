ad_page_contract {
    reject

    @author yon (yon@openforce.net)
    @creation-date 2002-03-15
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

dotlrn_community::membership_reject -community_id $community_id -user_id $user_id

ad_returnredirect $referer
