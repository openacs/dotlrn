ad_page_contract {
    Search for a new user for dotLRN
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    search_text
}

set community_id [dotlrn_community::get_community_id]

# Just search
db_multirow users select_users {}

set context_bar {{one-community-admin Admin} "New User"}

ad_return_template
