
ad_page_contract {
    Displays a configuration page community
    
    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date 2001-10-24
} {
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
    # Pull out the NPP page ID and render it!
    set page_id [dotlrn_community::get_page_id $community_id $user_id]

    # Get the portal's name for the title
    set name [portal::get_name $page_id]

    set rendered_page [portal::configure $page_id]

    set context_bar {Configure}

    ad_return_template
}
