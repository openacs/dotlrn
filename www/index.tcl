
ad_page_contract {
    Displays the personal home page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
} -properties {
    classes:multirow
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

# Get the page
set page_id [db_string select_page_id {} -default ""]

# If there is no page_id, this user is either a guest or something else
if {[empty_string_p $page_id]} {
    # do something
} else {
    set rendered_page [portal::render $page_id]
}


ad_return_template
