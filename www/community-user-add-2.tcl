
ad_page_contract {
    Search for a new user for dotLRN
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    user_id
}

set community_id [dotlrn_community::get_community_id]

# Get user information
db_1row select_user_info "select first_names, last_name, email from dotlrn_users where user_id=:user_id"

# Depending on the community_type, we have allowable rel_types
set rel_types [dotlrn_community::get_allowed_rel_types -community_id $community_id]

template::multirow create roles rel_type pretty_name

foreach rel_type $rel_types {
    template::multirow append roles [lindex $rel_type 0] [lindex $rel_type 1]
}

ad_return_template
