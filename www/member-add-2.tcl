ad_page_contract {
    Search for a new user for dotLRN
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    user_id
    {referer "one-community-admin"}
} -properties {
    roles:multirow
}
set portal_id ""
set community_id [dotlrn_community::get_community_id]

dotlrn::require_user_admin_community $community_id

# Get user information
db_1row select_user_info {
    select first_names,
           last_name,
           email
    from dotlrn_users
    where user_id = :user_id
}

# Depending on the community_type, we have allowable rel_types
set rel_types [dotlrn_community::get_allowed_rel_types -community_id $community_id]

template::multirow create roles rel_type pretty_name

foreach rel_type $rel_types {
    template::multirow append roles $rel_type [dotlrn_community::get_role_pretty_name_from_rel_type -rel_type $rel_type]
}

ad_return_template
