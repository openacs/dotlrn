
ad_page_contract {
    Displays single dotLRN class instance page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-07
} {
    class_instance_id
}

# Get information about that class
if {![db_0or1row select_class_instance_info {}]} {
    ad_returnredirect "classes"
    return
}

# Get all users for this community, including role
set users [dotlrn_community::list_users $class_instance_id]

template::multirow create users rel_id rel_type user_id first_names last_name email

foreach user $users {
    template::multirow append users [lindex $user 0] [lindex $user 1] [lindex $user 2] [lindex $user 3] [lindex $user 4] [lindex $user 5]
}

ad_return_template
