
ad_page_contract {
    A simple target for the portal configuration
    
    @author Arjun Sanyal (arjun@openforce.net)
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-24
} {

}


set form [ns_getform]
set portal_id [ns_set get $form portal_id]

# Check if this is a community type level thing
if {[ad_parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    return
}


# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

# If there is no portal_id, this user is either a guest or something else
if {![empty_string_p $portal_id]} {
    portal::configure_dispatch $portal_id $form
}

ad_returnredirect "configure"


