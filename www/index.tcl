ad_page_contract {
    Displays the personal home page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
}

# Check if this is a community type level thing
if {[ad_parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    ad_script_abort
}

# Check if this is a community level thing
if {[ad_parameter community_level_p] == 1} {
    ad_returnredirect "one-community"
    ad_script_abort
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

# Permission dotLRN
if {![dotlrn::user_can_browse_p]} {
    ns_log Notice "DOTLRN- CANNOT BROWSE!"

    # Figure out if the user is a member of a community
    set communities [dotlrn_community::get_all_communities_by_user $user_id]

    if {[llength $communities] == 0} {
        ad_return_template index-not-a-user
        return
    }

    # For now, we assume only ONE community (FIXME: ben)
    set the_community [lindex $communities 0]
    ad_returnredirect [dotlrn_community::get_url_from_package_id -package_id [lindex $the_community 4]]

    ad_script_abort
    return
}

# Get the page
set portal_id [dotlrn::get_workspace_portal_id $user_id]

set rendered_page [dotlrn::render_page $portal_id]

ad_return_template
