
ad_page_contract {
    Displays single dotLRN community page for admin
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-27
} {
    community_id
}

# Permissions
dotlrn::require_user_admin_community $community_id

# Get information about that class
db_1row select_community_info {}

# Get all users for this community, including role
set list_of_users [dotlrn_community::list_users $community_id]

template::multirow create users rel_id rel_type user_id first_names last_name email

foreach user $list_of_users {
    template::multirow append users [lindex $user 0] [dotlrn_community::get_pretty_rel_type [lindex $user 1]] [lindex $user 2] [lindex $user 3] [lindex $user 4] [lindex $user 5]
}

ad_return_template
