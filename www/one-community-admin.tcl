ad_page_contract {
    Displays single dotLRN community page for admin
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-27
    @version $Id$
} -query {
} -properties {
    dotlrn_admin_p:onevalue
    dotlrn_admin_url:onevalue
    community_id:onevalue
    community_type:onevalue
    pretty_name:onevalue
    description:onevalue
    subgroups:multirow
}

set community_id [dotlrn_community::get_community_id]

dotlrn::require_user_admin_community $community_id

set dotlrn_admin_p [dotlrn::admin_p]
set dotlrn_admin_url "[dotlrn::get_url]/admin"

db_1row select_community_info {}

db_multirow subgroups select_subgroups_count {
    select 1 from dual where 1 = 0
}

set context_bar {Admin}

ad_return_template
