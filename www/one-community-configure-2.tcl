
ad_page_contract {
    A simple target for the portal configuration
    
    @author Arjun Sanyal (arjun@openforce.net)
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-24
} {
    portal_id:naturalnum,notnull
}

# Check that this is a community type
if {[ad_parameter community_level_p] != 1} {
    ns_returnredirect "./"
    return
}

set user_id [ad_conn user_id]

# What community type are we at?
set community_id [dotlrn_community::get_community_id]

# Check that this user is a member
if {![dotlrn_community::member_p $community_id $user_id]} {
    set context_bar [list "Not a member"]

    ad_return_template one-community-not-member
    return
} else {

    # just call this, it will sort it out
    portal::configure_dispatch $portal_id [ad_conn query]

    ns_returnredirect "one-community-configure"
}
