ad_page_contract {
    Displays a community type
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-04
} {
}

ns_log notice "XXX0.6"

# Check that this is a community type
if {[ad_parameter community_type_level_p] != 1} {
    ad_returnredirect "./"
    ad_script_abort
} 

set user_id [ad_conn user_id]

# What community type are we at?
set community_type [dotlrn_community::get_community_type]

# Load some community type info
db_1row select_community_type_info {}

# Check what communities of this type the user is a member of
# cause we want to display that!
set member_communities [dotlrn_community::get_communities_by_user $community_type $user_id]

# Load all active communities for this community type
set list_of_active_communities [dotlrn_community::get_active_communities $community_type]

# data source
template::multirow create active_communities community_id community_type pretty_name description url admin_p member_p

# Loop and create the data source (I am very unhappy with db_multirow. VERY - bma)
foreach comm $list_of_active_communities {
    # See if user can admin this
    if {[dotlrn::user_can_admin_community_p [lindex $comm 0]]} {
	set admin_p 1
    } else {
	set admin_p 0
    }

    if {[lsearch [lindex $comm 0] $member_communities]} {
	set member_p 1
    } else {
	set member_p 0
    }

    template::multirow append active_communities [lindex $comm 0] [lindex $comm 1] [lindex $comm 2] [lindex $comm 3] [lindex $comm 4] $admin_p $member_p
}

set context_bar {View}

ad_return_template
