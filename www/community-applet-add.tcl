
ad_page_contract {
    Add an applet to a community
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-08
} {
    applet_key
}

set community_id [dotlrn_community::get_community_id]

# Check access
if {![dotlrn_community::admin_access_p $community_id]} {
    ns_returnredirect /
    return
}

# Add the applet
dotlrn_community::add_applet $community_id $applet_key

# Get back to where you once belonged
ns_returnredirect community-applets?community_id=$community_id
