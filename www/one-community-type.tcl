
ad_page_contract {
    Displays a community type
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-04
} {
}

# Check that this is a community type
if {[ad_parameter community_type_level_p] != 1} {
    ns_returnredirect "./"
    return
} 

set user_id [ad_conn user_id]

# What community type are we at?
set community_type [dotlrn_community::get_community_type]

# Load some community type info
db_1row select_community_type_info {}

# Check what communities of this type the user is a member of
# cause we want to display that!
set list_of_communities [dotlrn_community::get_communities_by_user $community_type $user_id]

# communities should be a data source
template::multirow create communities community_id community_type pretty_name description url

foreach comm $list_of_communities {
    template::multirow append communities [lindex $comm 0] [lindex $comm 1] [lindex $comm 2] [lindex $comm 3] [lindex $comm 4]
}

ad_return_template
