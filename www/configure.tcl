ad_page_contract {
    Displays a configuration page

    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-24
    @version $Id$
} -query {
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
	set portal_id [dotlrn_community::get_portal_id $community_id $user_id]
	set rendered_page [portal::configure $portal_id "one-community"]
	set context_bar {Configure}
	set name [portal::get_name $portal_id]
    }
} else {
    # this not a community, it is the "workspace" deal

    # Get the page
    set portal_id [db_string select_portal_id {} -default ""]

    # If there is no portal_id, this user is either a guest or something else
    if {[empty_string_p $portal_id]} {
	# do something
	ad_returnredirect "./"
    } else {
	set rendered_page [portal::configure $portal_id "index"]
	set name [portal::get_name $portal_id]
    }
}

ad_return_template
