
ad_page_contract {
    Remove an applet from a community
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-08
} {
    applet_key
}

# Get the community ID
set community_id [dotlrn_community::get_community_id]

# Check access
if {![dotlrn_community::admin_access_p $community_id]} {
    ns_returnredirect /
    return
}

# Add the applet
dotlrn_community::remove_applet $community_id $applet_key

# Get back to where you once belonged
ns_returnredirect one-community-admin
