

ad_page_contract {
    Community Applets
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
} {
    community_id
}

# Check that this is a community type
if {[ad_parameter community_level_p] != 1} {
    ns_returnredirect "./"
    return
}

set user_id [ad_conn user_id]

# Load some community type info
db_1row select_community_info {}

# Get active applets
set list_of_active_applets [dotlrn_community::list_applets $community_id]

template::multirow create active_applets applet_key applet_pretty_name

foreach applet_key $list_of_active_applets {
    template::multirow append active_applets $applet_key [dotlrn_community::applet_call $applet_key GetPrettyName]
}


# List all applets
set list_of_applets [dotlrn_community::list_applets]

template::multirow create all_applets applet_key applet_pretty_name

foreach applet_key $list_of_applets {
    if {[lsearch $list_of_active_applets $applet_key] == -1} {
	template::multirow append all_applets $applet_key [dotlrn_community::applet_call $applet_key GetPrettyName]
    }
}

set context_bar {Admin}

ad_return_template
