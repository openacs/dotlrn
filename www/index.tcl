
ad_page_contract {
    Displays the personal home page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
}

# Check if this is a community type level thing
if {[ad_parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    return
}

# Check if this is a community level thing
if {[ad_parameter community_level_p] == 1} {
    ad_returnredirect "one-community"
    return
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

# Get the page
set page_id [db_string select_page_id {} -default ""]

# If there is no page_id, this user is either a guest or something else
if {[empty_string_p $page_id]} {
    # do something
} else {
    set rendered_page [dotlrn::render_page $page_id]
}


ad_return_template
