
#
# Procs for dotLRN Security
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# October 30th, 2001
# ben@openforce.net
#

ad_library {

    Procs to manage DOTLRN Security

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@milliped.com)
    @creation-date 2001-10-30
    @version $Id$

}

namespace eval dotlrn {

    ad_proc -private do_abort {} {
        do an abort if security violation
    } {
        ad_returnredirect "not-allowed"
        return -code error
    }

    ad_proc -public get_user_types {} {
        return the list of possible user types
    } {
        return [db_list_of_lists select_user_types {}]
    }

    ad_proc -public get_user_types_as_options {} {
        return the list of possible user types
    } {
        return [db_list_of_lists select_user_types_as_options {}]
    }

    ad_proc -public user_p {
        {-user_id:required}
    } {
        check if a user is a dotLRN user
    } {
        return [db_string select_count {
            select count(*)
            from dual
            where exists (select 1
                          from dotlrn_users
                          where user_id = :user_id)
        }]
    }

    ad_proc -public user_add {
        {-type "student"}
        {-access_level "limited"}
        {-id ""}
        {-user_id:required}
    } {
        Add a user as a dotLRN user
    } {
        # Check if the user is already a dotLRN user
        if {[user_p -user_id $user_id]} {
            return
        }

        # set up extra vars
        set extra_vars [ns_set create]
        ns_set put $extra_vars user_id $user_id
        ns_set put $extra_vars id $id

        db_transaction {

            # get the first page name and theme
            set page_name_and_layout_list [split [ad_parameter -package_id [dotlrn::get_package_id] user_wsp_page_names "Untitled Page,Simple 2-Column;" ] ";"]
            set page_name_list [list]
            set layout_name_list [list]

            # seperate name and theme
            foreach item $page_name_and_layout_list {
                lappend page_name_list [lindex [split $item ","] 0]
                lappend layout_name_list [lindex [split $item ","] 1]
            }

            if {[string equal $access_level "full"] == 1} {
                # Create a portal page for this user
                set portal_id [portal::create \
                        -name "Your dotLRN Workspace" \
                        -default_page_name [lindex $page_name_list 0] \
                        -layout_name [lindex $layout_name_list 0] \
                        $user_id]

                # create rest of the default pages from the ad_param
                for {set i 1} {$i < [expr [llength $page_name_list]]} {incr i} {
                    portal::page_create -portal_id $portal_id \
                            -pretty_name [lindex $page_name_list $i] \
                            -layout_name [lindex $layout_name_list $i]
                }

                # manually switch back to the first page
                set page_id [portal::get_page_id -portal_id $portal_id -sort_key 0]

                # aks test adding applets on new pages
                # make a test page to the wsp
                dotlrn_main_portlet::add_self_to_page -page_id $page_id $portal_id {}
                # end test

                # Update the user and set the portal page correctly
                ns_set put $extra_vars portal_id $portal_id
            }

            # Add the relation (no need to feed in anything for object_id_one, or two for that matter).
            set rel_id [relation_add \
                -extra_vars $extra_vars \
                -member_state approved \
                [get_rel_type_from_user_type -type $type -access_level $access_level] \
                "" \
                $user_id]

            if {[string equal $access_level "full"] == 1} {
                # must be here since wsp must exist in the dotlrn_full_users table,
                #do the callbacks on the active dotlrn-wide applets
                dotlrn_community::applets_dispatch \
                        -op AddUser \
                        -list_args [list $user_id]
            }
        }

        return $rel_id
    }

    ad_proc -public user_remove {
        {-user_id:required}
    } {
        Remove a user from the set of dotLRN users
    } {
        set rel_id [db_string select_rel_id {} -default ""]

        if {![empty_string_p $rel_id]} {
            relation_remove $rel_id
        }
    }

    ad_proc -public users_remove {
        {-users:required}
    } {
        Remove a set of users from dotLRN
    } {
        db_transaction {
            foreach user $users {
                user_remove -user_id $user
            }
        }
    }

    ad_proc -public remove_user_completely {
        {-user_id:required}
    } {
        Remove the user from ACS as well
    } {
        if {[user_p -user_id $user_id]} {
            user_remove -user_id $user_id
        }

        acs_user::delete -user_id $user_id
    }

    ad_proc -public remove_users_completely {
        {-users:required}
    } {
        Remove a set of users from the ACS
    } {
        db_transaction {
            foreach user $users {
                remove_user_completely -user_id $user
            }
        }
    }

    ad_proc -private user_get_type {
        user_id
    } {
        returns the dotLRN user role or empty string if not a dotLRN user
    } {
        return [db_string select_user_type {} -default ""]
    }

    ad_proc -public user_can_browse_p {
        {user_id ""}
    } {
        Check is a user can browse dotLRN
    } {
        return [ad_permission_p -user_id $user_id [dotlrn::get_package_id] dotlrn_browse]
    }

    ad_proc -public require_user_browse {
        {user_id ""}
    } {
        Require that a user be able to browse dotLRN
    } {
        if {![user_can_browse_p -user_id $user_id]} {
            do_abort
        }
    }

    ad_proc -public set_user_read_private_data {
        {-user_id:required}
        val
    } {
        set whether or not a user can read private data
    } {
        acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] $val
    }

    ad_proc -public user_can_read_private_data_p {
        {user_id ""}
    } {
        Check if a user can read sensitive data in dotLRN
    } {
        if {[empty_string_p $user_id]} {
            set user_id [ad_conn user_id]
        }

        return [acs_privacy::user_can_read_private_data_p -user_id $user_id -object_id [dotlrn::get_package_id]]
    }

    ad_proc -public require_user_read_private_data {
        {user_id ""}
    } {
        Require that a user be able to read sensitive data
    } {
        if {![user_can_read_private_data_p -user_id $user_id]} {
            do_abort
        }
    }

    ad_proc -public user_can_read_community_type_p {
        {-user_id ""}
        community_type
    } {
        Check if a user can read a community type
    } {
        # FIXME: permission hack
        # NOT SURE HOW TO FIX THIS WITHOUT object_ids on community types
        return 1
    }

    ad_proc -public require_user_read_community_type {
        {-user_id ""}
        community_type
    } {
        require that a user be able to read a community type
    } {
        if {![user_can_read_community_type_p -user_id $user_id $community_type]} {
            do_abort
        }
    }

    ad_proc -public user_can_read_community_p {
        {-user_id ""}
        community_id
    } {
        Check if a user can read a community
    } {
        return [ad_permission_p -user_id $user_id $community_id dotlrn_view_community]
    }

    ad_proc -public require_user_read_community {
        {-user_id ""}
        community_id
    } {
        require that a user be able to read a community
    } {
        if {![user_can_read_community_p -user_id $user_id $community_id]} {
            do_abort
        }
    }

    ad_proc -public user_is_community_member_p {
        {-user_id ""}
        community_id
    } {
        check if a user is a member of a community
    } {
        if {[empty_string_p $user_id]} {
            set user_id [ad_conn user_id]
        }

        return [dotlrn_community::member_p $community_id $user_id]
    }

    ad_proc -public require_user_community_member {
        {-user_id ""}
        community_id
    } {
        require that a user be member of a particular community
    } {
        if {![user_is_community_member_p -user_id $user_id $community_id]} {
            do_abort
        }
    }

    ad_proc -public user_can_admin_community_p {
        {-user_id ""}
        community_id
    } {
        check if a user can admin a community
    } {
        return [ad_permission_p -user_id $user_id $community_id dotlrn_admin_community]
    }

    ad_proc -public require_user_admin_community {
        {-user_id ""}
        community_id
    } {
        require that user be able to admin a community
    } {
        if {![user_can_admin_community_p -user_id $user_id $community_id]} {
            do_abort
        }
    }

}
