
ad_page_contract {
    Displays the personal home page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
}

ns_log notice "XXX0"

# Check if this is a community type level thing
if {[ad_parameter community_type_level_p] == 1} {
    ns_log notice "XXX0.5"
    ad_returnredirect "one-community-type"
    ns_log notice "XXX0.55"
    ad_script_abort
    ns_log notice "XXX0.60"
}

ns_log notice "XXX1"

# Check if this is a community level thing
if {[ad_parameter community_level_p] == 1} {
    ad_returnredirect "one-community"
    ad_script_abort
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

# Get the page
set portal_id [dotlrn::get_workspace_portal_id $user_id]

# If there is no portal_id, this user is either a guest or something else
if {[empty_string_p $portal_id]} {
    # do something
    ad_return_template index-not-a-user
    return
} else {
    set rendered_page [dotlrn::render_page $portal_id]
}

ad_return_template
