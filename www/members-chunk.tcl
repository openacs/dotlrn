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

set referer [ns_conn url]

set site_wide_admin_p [ad_permission_p -user_id $user_id [acs_magic_object "security_context_root"] "admin"]
if {!$site_wide_admin_p} {
    set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id $community_id]
    set read_private_data_p [dotlrn::user_can_read_private_data_p $user_id]
} else {
    set admin_p 1
    set read_private_data_p 1
}

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

set user_list [list]
foreach user $list_of_users {
    lappend user_list [lindex $user 2]
    template::multirow append users \
        [lindex $user 0] \
        [dotlrn_community::get_role_pretty_name_from_rel_type -rel_type [lindex $user 1]] \
        [lindex $user 2] \
        [lindex $user 3] \
        [lindex $user 4] \
        [lindex $user 5]
}

db_multirow pending_users select_pending_users {
    select dotlrn_users.*,
           dotlrn_member_rels_full.rel_type,
           dotlrn_member_rels_full.role
    from dotlrn_users,
         dotlrn_member_rels_full
    where dotlrn_users.user_id = :user_id
    and dotlrn_users.user_id = dotlrn_member_rels_full.user_id
    and dotlrn_member_rels_full.community_id = :community_id
    and dotlrn_member_rels_full.member_state = 'needs approval'
}


#  If we are in a subcomm. get the list of the users of the parent
# comm that are not in the subcomm yet, and output them with radios
# for roles, etc.

set subcomm_p [dotlrn_community::subcommunity_p -community_id $community_id]

if {$subcomm_p} {
    # Get all users for this community, including role
    set list_of_parent_users [dotlrn_community::list_possible_subcomm_users \
            -subcomm_id $community_id]
    
    template::multirow create parent_users rel_id rel_type user_id first_names last_name email
    
    set parent_user_list [list]
    foreach parent_user $list_of_parent_users {
        lappend parent_user_list [lindex $parent_user 2]
        template::multirow append parent_users \
                [lindex $parent_user 0] \
                [dotlrn_community::get_role_pretty_name_from_rel_type -rel_type [lindex $parent_user 1]] \
                [lindex $parent_user 2] \
                [lindex $parent_user 3] \
                [lindex $parent_user 4] \
                [lindex $parent_user 5]
    }
}

ad_return_template    
    
