
ad_page_contract {
    A simple target for the portal element configuration
    
    @author Arjun Sanyal (arjun@openforce.net)
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-24
} {
    element_id:integer
    key
    value
}


# Check if this is a community type level thing
if {[ad_parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    return
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

# XXX security
portal::set_element_param $element_id $key $value


ad_returnredirect "."


