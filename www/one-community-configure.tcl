
ad_page_contract {
    Displays a configuration page
    
    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date 2001-10-24
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
    set rendered_page [portal::configure $page_id]
    set name [portal::get_name $page_id]
}


ad_return_template

