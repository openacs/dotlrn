ad_page_contract {
    Admin the admin users of a community
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
} {
}

# Get basic information
set user_id [ad_get_user_id]
set community_id [dotlrn_community::get_community_id]

# Get current admin users
set admin_users [dotlrn_community::list_admin_users $community]

template::multirow create admins user_id first_names last_name email role

foreach admin $admin_users {
    template::multirow append admins [lindex $admin 1] [lindex $admin 2] [lindex $admin 3] [lindex $admin 4] [lindex $admin 5]
}

ad_return_template
