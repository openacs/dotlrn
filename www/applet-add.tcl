ad_page_contract {
    Add an applet to a community
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-08
    @version $Id$
} -query {
    applet_key
    {referer "applets"}
}

set community_id [dotlrn_community::get_community_id]

# Check access
if {![dotlrn_community::admin_access_p $community_id]} {
    ad_returnredirect /
    ad_script_abort
}

# Add the applet
dotlrn_community::add_applet_to_community $community_id $applet_key

ad_returnredirect $referer
