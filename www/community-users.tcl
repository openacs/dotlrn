# dotlrn/www/community-users.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Jan 08, 2002
    @version $Id$
} -query {
} -properties {
}

set community_id [dotlrn_community::get_community_id]

# Permissions
dotlrn::require_user_admin_community $community_id

# Get all users for this community, including role
set list_of_users [dotlrn_community::list_users $community_id]

template::multirow create users rel_id rel_type user_id first_names last_name email

foreach user $list_of_users {
    template::multirow append users [lindex $user 0] [dotlrn_community::get_role_pretty_name_from_rel_type -rel_type [lindex $user 1]] [lindex $user 2] [lindex $user 3] [lindex $user 4] [lindex $user 5]
}

ad_return_template
