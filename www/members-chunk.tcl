# dotlrn/www/members-chunk.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 08, 2002
    @version $Id$
} -query {
} -properties {
    users:multirow
}

set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]

set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id $community_id]
set read_private_data_p [dotlrn::user_can_read_private_data_p $user_id]

if {![exists_and_not_null referer]} {
    if {[string equal $admin_p "t"] == 1} {
        set referer "one-community-admin"
    } else {
        set referer "one-community"
    }
}

# Get all users for this community, including role
set list_of_users [dotlrn_community::list_users $community_id]

template::multirow create users rel_id rel_type user_id first_names last_name email

foreach user $list_of_users {
    template::multirow append users \
        [lindex $user 0] \
        [dotlrn_community::get_role_pretty_name_from_rel_type -rel_type [lindex $user 1]] \
        [lindex $user 2] \
        [lindex $user 3] \
        [lindex $user 4] \
        [lindex $user 5]
}

ad_return_template
