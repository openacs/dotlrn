ad_page_contract {
    Add the new user

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    user_id
    rel_type
    {referer "one-community-admin"}
}

set community_id [dotlrn_community::get_community_id]

# Add the relation
dotlrn_community::add_user -rel_type $rel_type $community_id $user_id

ad_returnredirect $referer
