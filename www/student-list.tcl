
ad_page_contract {
    Displays a community student list
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-09
} {
}

# Check that this is a community type
if {[ad_parameter community_level_p] != 1} {
    ns_returnredirect "./"
    return
}

set user_id [ad_conn user_id]

# What community type are we at?
set community_id [dotlrn_community::get_community_id]

# Get basic information
db_1row select_community_info {}

set list_of_students [dotlrn_community::list_users $community_id]

template::multirow create students user_id first_names last_name email

foreach student $list_of_students {
    ns_log Notice "one student - $student"
    template::multirow append students [lindex $student 1] [lindex $student 2] [lindex $student 3] [lindex $student 4]
}

ad_return_template
