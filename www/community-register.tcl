ad_page_contract {
    register
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-06
    @version $Id$
} -query {
    {community_id ""}
    {referer "./"}
}

ad_maybe_redirect_for_registration

set user_id [ad_conn user_id]

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn_community::add_user $community_id $user_id

ad_returnredirect $referer
