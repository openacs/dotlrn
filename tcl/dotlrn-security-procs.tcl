#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#


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
    @author yon (yon@openforce.net)
    @creation-date 2001-10-30
    @version $Id$

}

namespace eval dotlrn {

    ad_proc -public generate_key {
        {-name:required}
        {-increment:boolean}
    } {
        Generate a key from a name. Compresses all adjacent non-alphanum
        chars to a dash. Yes, this is not unique, grows rapidly, will
        need collision detection and resolution, yada yada.
    } {
        set next ""
        regsub -all {\W+} $name "-" name
        regsub -all -- {-+} $name "-" name
        set name [string tolower [string trim $name {-}]]

        if {$increment_p} {
            # increment the key by checking if the last 2 chars are -int
            # if so, incr the int. if not add "-1" to the key
            regexp -- {^(.*)-(\d+)$} $name match namepart intpart

            if {[info exists intpart]} {
                set name "$namepart-[incr intpart]"
            } else {
                set name "$name-1"
            }
        }
        
        return $name
    }

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
        ns_set put $extra_vars access_level $access_level
        ns_set put $extra_vars id $id

        set template_id \
                [dotlrn_community::get_type_portal_id -community_type "user_workspace"]
        db_transaction {
            set portal_id [portal::create \
                -template_id $template_id \
                -name "Your dotLRN Workspace" \
                $user_id
            ]

            ns_set put $extra_vars portal_id $portal_id

            # Add the relation (no need to feed in anything for object_id_one,
            # or two for that matter).
            set rel_id [relation_add \
                -extra_vars $extra_vars \
                -member_state approved \
                [get_rel_type_from_user_type -type $type] \
                "" \
                $user_id \
            ]

            # add the "dotlrn main" portlet to the user's workspace
            dotlrn_main_portlet::add_self_to_page -portal_id $portal_id

            dotlrn_community::applets_dispatch -op AddUser -list_args [list $user_id]

            # if the user is a member of communities (from some previous
            # dotlrn relation) then we must remove them from the community and
            # re-add them so that all the portals will work properly.
            # NOTE: we cannot do this in a db_foreach beacause of the table we
            # are selecting from changes inside the loop causing all kinds of
            # dead lock issues.
            set current_memberships [db_list_of_ns_sets select_current_memberships {
                select community_id,
                       rel_type,
                       member_state
                from dotlrn_member_rels_full
                where user_id = :user_id
            }]

            foreach row $current_memberships {
                dotlrn_community::remove_user [ns_set get $row community_id] $user_id
                dotlrn_community::add_user \
                    -rel_type [ns_set get $row rel_type] \
                    -member_state [ns_set get $row member_state] \
                    [ns_set get $row community_id] \
                    $user_id
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
        return [permission::permission_p \
            -party_id $user_id \
            -object_id [dotlrn::get_package_id] \
            -privilege "dotlrn_browse" \
        ]
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
        acs_privacy::set_user_read_private_data \
            -user_id $user_id \
            -object_id [dotlrn::get_package_id] \
            $val
    }

    ad_proc -public user_can_read_private_data_p {
        {user_id ""}
    } {
        Check if a user can read sensitive data in dotLRN
    } {
        if {[empty_string_p $user_id]} {
            set user_id [ad_conn user_id]
        }

        return [acs_privacy::user_can_read_private_data_p \
            -user_id $user_id \
            -object_id [dotlrn::get_package_id] \
        ]
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
        return [permission::permission_p \
            -party_id $user_id \
            -object_id $community_id \
            -privilege "dotlrn_view_community" \
        ]
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
        return [permission::permission_p \
            -party_id $user_id \
            -object_id $community_id \
            -privilege "dotlrn_admin_community" \
        ]
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
