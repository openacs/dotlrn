
ad_page_contract {
    Displays an element configuration page
    
    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date 2001-10-24
} -query {
    element_id:naturalnum,notnull
    op:notnull
}

# Check if this is a community type level thing
if {[ad_parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    return
}

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]


if {[ad_parameter community_level_p] == 1} {
    # This is a community
    # What community type are we at?
    set community_id [dotlrn_community::get_community_id]

    # Check that this user is a member
    if {![dotlrn_community::member_p $community_id $user_id]} {
	set context_bar [list "Not a member"]

	ad_return_template one-community-not-member
	return
    } else {

	# they are a member, do the request
	set rendered_page \
		[portal::configure_element $element_id $op "one-community"]
    }
} else {
    # this not a community, it is the "workspace" deal
    
    # Get the page
    set portal_id [db_string select_portal_id {} -default ""]
    
    # If there is no portal_id, this user is either a guest or something else
    if {[empty_string_p $portal_id]} {
	# do something
	ad_returnredirect "/."
    } else {
	set rendered_page [portal::configure_element $element_id $op "index"]
    }
}
    
ad_return_template 



