

ad_page_contract {
    Admin a community
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
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

# Load some community type info
db_1row select_community_type_info {}

# Check what communities of this type the user is a member of
# cause we want to display that!
set communities [dotlrn_community::get_communities_by_user $community_type $user_id]

# communities should be a data source

ad_return_template
