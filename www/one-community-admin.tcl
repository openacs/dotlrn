ad_page_contract {
    Displays single dotLRN community page for admin

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-27
    @version $Id$
} -query {
} -properties {
    community_id:onevalue
    community_type:onevalue
    pretty_name:onevalue
    description:onevalue
    portal_template_id:onevalue
    users:multirow
}

set community_id [dotlrn_community::get_community_id]
set user_id [ad_get_user_id]

# Permissions
dotlrn::require_user_admin_community $community_id

db_1row select_community_info {}

# render the admin page
set rendered_page [dotlrn::render_page -render_style all_in_one $admin_portal_id]

set portal_id [dotlrn_community::get_portal_id $community_id $user_id]

set context_bar {Admin}

ad_return_template
