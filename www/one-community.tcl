ad_page_contract {
    Displays a community
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-04
    @version $Id$
} -query {
} -properties {
}

# Check that this is a community type
if {[ad_parameter community_level_p] != 1} {
    ns_returnredirect "./"
    ad_script_abort
}

set user_id [ad_conn user_id]

# What community type are we at?
set community_id [dotlrn_community::get_community_id]

# Get basic information
db_1row select_community_info {}

# Check that this user is a member
if {![dotlrn_community::member_p $community_id $user_id]} {
    set context_bar [list "Not a member"]

    if {[dotlrn_community::member_pending_p -community_id $community_id -user_id $user_id]} {
        set member_pending_p "t"
        set context_bar [list "Pending approbal"]
    }

    set portal_id [dotlrn_community::get_community_non_members_portal_id $community_id]

    # Possible that there is no portal page for non-members
    if {! [empty_string_p $portal_id]} {
	set rendered_page [dotlrn::render_page $portal_id]
    } else {
	set rendered_page ""
    }

    ad_return_template one-community-not-member
    return
} else {
    # Pull out the NPP page ID and render it!
    set portal_id [dotlrn_community::get_portal_id $community_id $user_id]

    set rendered_page [dotlrn::render_page $portal_id]

    set context_bar {View}

    set admin_p [dotlrn::user_can_admin_community_p $community_id]

    ad_return_template
}
