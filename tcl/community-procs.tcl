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

ad_library {

    Procs to manage DOTLRN Communities

    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-09-28
    @version $Id$

}

namespace eval dotlrn_community {

    ad_proc -public is_initialized {
        {-community_type:required}
    } {
        is this dotlrn_community type initialized correctly?
    } {
        return [db_string is_dotlrn_community_type_initialized {
            select count(*)
            from dotlrn_community_types
            where community_type = :community_type
            and package_id is not null
        }]
    }

    ad_proc -public init {
        {-community_type:required}
        {-community_type_url_part:required}
        {-pretty_name ""}
    } {
        create base community_type for dotlrn_community type
    } {
        db_transaction {
            if {![dotlrn::is_instantiated_here -url "[dotlrn::get_url]/${community_type_url_part}/"]} {
                set package_id [dotlrn::mount_package \
                    -package_key [dotlrn::package_key] \
                    -url $community_type_url_part \
                    -pretty_name $pretty_name \
                    -directory_p "t"]

                dotlrn_community::set_type_package_id $community_type $package_id

                ad_parameter -package_id $package_id -set 0 dotlrn_level_p
                ad_parameter -package_id $package_id -set 1 community_type_level_p
                ad_parameter -package_id $package_id -set 0 community_level_p
            }
        }
    }

    ad_proc -public one_community_package_key {} {
        return "dotlrn"
    }

    ad_proc -public one_community_type_package_key {} {
        return "dotlrn"
    }

    ad_proc -public new_type {
        {-description ""}
        {-community_type_key:required}
        {-parent_type "dotlrn_community"}
        {-pretty_name:required}
        {-url_part ""}
    } {
        Create a new community type.
    } {
        # Figure out parent_node_id
        set parent_node_id [get_type_node_id $parent_type]
        array set parent_node [site_node [site_nodes::get_url_from_node_id -node_id $parent_node_id]]

        db_transaction {
            # Create the class directly using PL/SQL API
            set community_type_key [db_exec_plsql create_community_type {}]

            # Create the node
            set new_node_id [site_node_create $parent_node_id [ad_decode $url_part "" $community_type_key $url_part]]

            # Instantiate the package
            set package_id [site_node_create_package_instance $new_node_id $pretty_name $parent_node(object_id) [one_community_type_package_key]]

            # Set some parameters
            ad_parameter -package_id $package_id -set 0 dotlrn_level_p
            ad_parameter -package_id $package_id -set 1 community_type_level_p
            ad_parameter -package_id $package_id -set 0 community_level_p

            # Set the site node
            dotlrn_community::set_type_package_id $community_type_key $package_id
        }

        return $community_type_key
    }

    ad_proc -public set_type_package_id {
        community_type
        package_id
    } {
        Update the package ID for the community type
    } {
        # Exec the statement, easy
        db_dml update_package_id {}
    }

    ad_proc -public get_type_node_id {
        community_type
    } {
        get the node ID of a community type
    } {
        return [db_string select_node_id {}]
    }

    ad_proc -public get_community_node_id {
        community_id
    } {
        get the node ID of a community
    } {
        return [db_string select_node_id {}]
    }

    ad_proc -public new {
        {-parent_community_id ""}
        {-description ""}
        {-community_type:required}
        {-object_type "dotlrn_community"}
        {-community_key ""}
        {-pretty_name:required}
        {-extra_vars ""}
    } {
        create a new community
    } {
        # Set up extra vars
        if {[empty_string_p $extra_vars]} {
            set extra_vars [ns_set create]
        }

        # generate the key from the passed in name
        set community_key [dotlrn::generate_key -name $pretty_name]

        # check if the name is already in use, if so, complain loudly
        if {![check_community_key_valid_p \
                -community_key $community_key \
                -parent_community_id $parent_community_id]} {
            ad_return_complaint \
                    1 "The name <strong>$pretty_name</strong> is already in use. \n
                       Please select a different name."
        }

        # Add core vars
        ns_set put $extra_vars parent_community_id $parent_community_id
        ns_set put $extra_vars community_type $community_type
        ns_set put $extra_vars community_key $community_key
        ns_set put $extra_vars pretty_name $pretty_name
        ns_set put $extra_vars pretty_plural $pretty_name
        ns_set put $extra_vars description $description
        ns_set put $extra_vars context_id [dotlrn::get_package_id]

        db_transaction {

            # Insert the community
            set community_id [package_instantiate_object \
                    -extra_vars $extra_vars $object_type]

            set user_id [ad_conn user_id]

            # based on the community_type:
            # 1. get the page_names and layouts
            # 2. the the list of default applets for this type
            if {[string equal $community_type "dotlrn_community"]} {
                set csv_list [ad_parameter subcomm_pages_csv]
                set default_applets [ad_parameter default_subcomm_applets]
            } elseif {[string equal $community_type "dotlrn_club"]} {
                set csv_list [ad_parameter club_pages_csv]
                set default_applets [ad_parameter default_club_applets]
             } else {
                set csv_list [ad_parameter class_instance_pages_csv]
                set default_applets \
                        [ad_parameter default_class_instance_applets]
            }

            set non_member_page_name [ad_parameter non_member_page_name]
            set admin_page_name [ad_parameter admin_page_name]

            # Create portal template page
            set portal_template_id \
                    [portal::create \
                    -portal_template_p "t" \
                    -name "$pretty_name Portal Template" \
                    -csv_list $csv_list \
                    -context_id $community_id \
                    $user_id ]

            # Create the non-member page
            set portal_id \
                    [portal::create \
                    -template_id $portal_template_id \
                    -name "$pretty_name Non-Member Portal" \
                    -default_page_name $non_member_page_name \
                    -context_id $community_id \
                    $user_id]

            # Create the admin page
            set admin_portal_id \
                    [portal::create \
                    -name "$pretty_name Administration Portal" \
                    -default_page_name $admin_page_name \
                    -context_id $community_id \
                    -layout_name "Simple 1-Column" \
                    $user_id]

            # update the portal_template_id and non_member_portal_id
            db_dml update_portal_ids {}

            # Set up the rel segments
            dotlrn_community::create_rel_segments -community_id $community_id

            # Set up the node
            if {[empty_string_p $parent_community_id]} {
                set parent_node_id [get_type_node_id $community_type]
            } else {
                set parent_node_id [get_community_node_id $parent_community_id]
            }

            # Create the node
            set new_node_id [site_node_create $parent_node_id $community_key]

            # Instantiate the package
            set package_id \
                    [site_node_create_package_instance \
                      $new_node_id \
                      $pretty_name \
                      $community_id \
                      [one_community_package_key] \
                    ]

            # Set the right parameters
            ad_parameter -package_id $package_id -set 0 dotlrn_level_p
            ad_parameter -package_id $package_id -set 0 community_type_level_p
            ad_parameter -package_id $package_id -set 1 community_level_p

            # Set up the node
            dotlrn_community::set_package_id $community_id $package_id

            # Add the default applets specified above. They are
            # different per community type!
            set default_applets_list \
                    [string trim [split $default_applets {,}]]

            foreach applet_key $default_applets_list {
                if {[dotlrn_applet::applet_exists_p -applet_key $applet_key]} {
                    dotlrn_community::add_applet_to_community \
                            $community_id \
                            $applet_key
                }
            }
        }

        return $community_id
    }

    ad_proc set_active_dates {
        {-community_id:required}
        {-start_date:required}
        {-end_date:required}
    } {
        set the community active begin and end dates
    } {
        set start_date "[template::util::date::get_property year $start_date] [template::util::date::get_property month $start_date] [template::util::date::get_property day $start_date]"
        set end_date "[template::util::date::get_property year $end_date] [template::util::date::get_property month $end_date] [template::util::date::get_property day $end_date]"
        set date_format "YYYY MM DD"

        db_dml set_active_dates {}
    }

    ad_proc set_package_id {
        community_id
        package_id
    } {
        Update the node ID for the community
    } {
        db_dml update_package_id {}
    }

    ad_proc admin_access_p {
        community_id
    } {
        Checks admin access to a community
    } {
        # HACK FOR NOW!! (ben) FIXIT
        return 1
    }

    ad_proc -public get_url {
        {-current_node_id ""}
        {-package_id ""}
    } {
        This gets the relative URL for a package_id under a particular node_id
    } {
        if {[empty_string_p $current_node_id]} {
            set current_node_id [site_node_id [ad_conn url]]
        }

        return [db_string select_node_url {} -default ""]
    }

    ad_proc -public get_url_from_package_id {
        {-package_id ""}
    } {
        This gets the relative URL for a package_id.
    } {
        return [util_memoize "dotlrn_community::get_url_from_package_id_memoized -package_id $package_id"]
    }

    ad_proc -public get_url_from_package_id_memoized {
        {-package_id ""}
    } {
        Memoizing helper
    } {
        return [db_string select_node_url {} -default ""]
    }

    ad_proc set_attribute {
        community_id
        attribute_name
        attribute_value
    } {
        Set an attribute for a community
    } {
        # Not sure what to do here yet
    }

    ad_proc -public get_allowed_rel_types {
        {-community_id:required}
    } {
        set community_type [get_community_type_from_community_id $community_id]

        # Subcomm
        if {$community_type == "dotlrn_community"} {
            return {dotlrn_member_rel dotlrn_admin_rel}
        }

        # club
        if {$community_type == "dotlrn_club"} {
            return {dotlrn_member_rel dotlrn_admin_rel}
        }

        # else, it's a class instance
        return {dotlrn_student_rel dotlrn_ta_rel dotlrn_instructor_rel dotlrn_ca_rel dotlrn_cadmin_rel}

    }

    ad_proc -public get_all_roles {} {
        return the list of roles used in dotLRN
    } {
        return {dotlrn_admin_rel dotlrn_member_rel dotlrn_instructor_rel dotlrn_cadmin_rel dotlrn_ca_rel dotlrn_ta_rel dotlrn_student_rel}
    }

    ad_proc -public get_all_roles_as_options {} {
        return the list of roles used in dotLRN
    } {
        set roles [list]

        foreach role [get_all_roles] {
            lappend roles [list [get_role_pretty_name_from_rel_type -rel_type $role] $role]
        }

        return $roles
    }

    ad_proc -public get_pretty_rel_type {
        rel_type
    } {
        Returns a pretty version of the rel_type
    } {
        return [db_string select_pretty_name {
            select pretty_name
            from acs_object_types
            where object_type = :rel_type
        }]
    }

    ad_proc -public get_role_pretty_name {
        {-role:required}
    } {
        Returns the pretty version of the role
    } {
        return [db_string select_role_pretty_name {} -default ""]
    }

    ad_proc -public get_role_pretty_name_from_rel_type {
        {-rel_type:required}
    } {
        Returns the pretty version of the role
    } {
        return [db_string select_role_pretty_name {} -default ""]
    }

    ad_proc -public get_role_pretty_name_from_rel_id {
        {-rel_id:required}
    } {
        Returns the pretty version of the role
    } {
        return [db_string select_role_pretty_name {} -default ""]
    }

    ad_proc -public get_rel_segment_id {
        {-community_id:required}
        {-rel_type:required}
    } {
        get the relational segment ID for a community and a rel type
    } {
        return [db_string select_rel_segment_id {} -default ""]
    }

    ad_proc -public create_rel_segments {
        {-community_id:required}
    } {
        create all the relational segments for a community
    } {
        # Get some information about the community
        set community_name [get_community_name $community_id]

        db_transaction {
            # Create a rel segment for Admins
            set member_segment_id [rel_segments_new $community_id dotlrn_member_rel "Members of $community_name"]
            set admin_segment_id [rel_segments_new $community_id dotlrn_admin_rel "Admins of $community_name"]

            # Grant permissions
            permission::grant -party_id $member_segment_id -object_id $community_id -privilege "read"
            permission::grant -party_id $member_segment_id -object_id $community_id -privilege "write"
            permission::grant -party_id $admin_segment_id -object_id $community_id -privilege "admin"
        }
    }

    ad_proc -public delete_rel_segments {
        {-community_id:required}
    } {
        remove the rel segments for a community
    } {
        # Take care of the admins
        set admin_segment_id [get_rel_segment_id -community_id $community_id -rel_type dotlrn_admin_rel]
        permission::revoke -party_id $admin_segment_id -object_id $community_id -privilege "admin"
        rel_segments_delete $admin_segment_id

        # Take care of the members
        set member_segment_id [get_rel_segment_id -community_id $community_id -rel_type dotlrn_member_rel]
        permission::revoke -party_id $member_segment_id -object_id $community_id -privilege "edit"
        rel_segments_delete $member_segment_id
    }

    ad_proc -public list_admin_users {
        community_id
    } {
        Returns list of admin users
    } {
        return [list_users -rel_type "dotlrn_admin_rel" $community_id]
    }

    ad_proc -public list_users {
        {-rel_type "dotlrn_member_rel"}
        community_id
    } {
        Returns the list of users with a membership_id, a user_id, first name, last name, email, and role
    } {
        return [db_list_of_ns_sets select_users {}]
    }

    ad_proc -public list_possible_subcomm_users {
        {-subcomm_id:required}
    } {
        Returns the list of users from the subcomm's parent group that
        are not already in the subcomm with a membership_id, a user_id,
        first name, last name, email, and role
    } {
        return [db_list_of_ns_sets select_possible_users {}]
    }

    ad_proc -public list_users_in_role {
        {-rel_type:required}
        community_id
    } {
        Returns the list of users with a membership_id, a user_id,
        first name, last name, email, in a given role.
    } {
        return [db_list_of_lists select_users_in_role {}]
    }

    ad_proc -public member_p {
        community_id
        user_id
    } {
        check membership
    } {
        return [db_string select_count_membership {}]
    }

    ad_proc -public member_pending_p {
        {-community_id:required}
        {-user_id:required}
    } {
        is this user awaiting membership in this community?
    } {
        return [db_string is_pending_membership {}]
    }

    ad_proc -public add_user {
        {-rel_type ""}
        {-member_state "approved"}
        community_id
        user_id
    } {
        add a user to a particular community
    } {
        if {[string equal [get_toplevel_community_type_from_community_id $community_id] "dotlrn_class_instance"]} {
            if {![empty_string_p $rel_type]} {
                dotlrn_class::add_user \
                    -rel_type $rel_type \
                    -community_id $community_id \
                    -user_id $user_id \
                    -member_state $member_state
            } else {
                dotlrn_class::add_user \
                    -community_id $community_id \
                    -user_id $user_id \
                    -member_state $member_state
            }
        } elseif {[string equal [get_toplevel_community_type_from_community_id $community_id] "dotlrn_club"]} {
            if {![empty_string_p $rel_type]} {
                dotlrn_club::add_user \
                    -rel_type $rel_type \
                    -community_id $community_id \
                    -user_id $user_id \
                    -member_state $member_state
            } else {
                dotlrn_club::add_user \
                    -community_id $community_id \
                    -user_id $user_id \
                    -member_state $member_state
            }
        } else {
            if {![empty_string_p $rel_type]} {
                add_user_to_community \
                    -rel_type $rel_type \
                    -community_id $community_id \
                    -user_id $user_id \
                    -member_state $member_state
            } else {
                add_user_to_community \
                    -community_id $community_id \
                    -user_id $user_id \
                    -member_state $member_state
            }
        }
    }

    ad_proc -public add_user_to_community {
        {-rel_type "dotlrn_member_rel"}
        {-community_id:required}
        {-user_id:required}
        {-member_state "approved"}
        {-extra_vars ""}
    } {
        Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
        if {[member_p $community_id $user_id]} {
            return
        }

        db_transaction {
            # Set up a portal page for that user and that community
            set portal_id [portal::create \
                -name "Your [get_community_name $community_id] page" \
                -template_id [get_portal_template_id $community_id] \
                $user_id \
            ]

            # Create the form with the portal_id
            if {[empty_string_p $extra_vars]} {
                set extra_vars [ns_set create]
            }
            ns_set put $extra_vars portal_id $portal_id
            ns_set put $extra_vars user_id $user_id
            ns_set put $extra_vars community_id $community_id

            # Set up the relationship
            set rel_id [relation_add \
                -member_state "needs approval" \
                -extra_vars $extra_vars \
                $rel_type \
                $community_id \
                $user_id \
            ]

            if {[string equal $member_state "approved"] == 1} {
                membership_approve -user_id $user_id -community_id $community_id
            }
        }
    }

    ad_proc -public membership_approve {
        {-user_id:required}
        {-community_id:required}
    } {
        Approve membership to a community
    } {
        db_1row select_rel_info {}

        db_transaction {
            membership_rel::approve -rel_id $rel_id

            applets_dispatch -community_id $community_id \
                -op AddUserToCommunity \
                -reorder_hack_p 1 \
                -list_args [list $community_id $user_id]
        }
    }

    ad_proc -public membership_reject {
        {-user_id:required}
        {-community_id:required}
    } {
        Reject membership to a community
    } {
        # This is the *right* thing to do, but for now we'll just remove them
        # (ben)
        # db_1row select_rel_info {}

        # db_transaction {
        #    membership_rel::reject -rel_id $rel_id
        #    if {![empty_string_p $portal_id]} {
        #        portal::delete $portal_id
        #    }
        # }
        
        remove_user $community_id $user_id
    }

    ad_proc -public remove_user {
        community_id
        user_id
    } {
        Removes a user from a community (and all subcomms she's a member of)
    } {
        db_transaction {
            # recursively drop membership from subgroups of this comm
            foreach subcomm_id [get_subcomm_list -community_id $community_id] {
                if { [member_p $subcomm_id $user_id] } {
                    remove_user $subcomm_id $user_id
                }
            }

            # Do Callbacks
            applets_dispatch \
                -community_id $community_id \
                -op RemoveUserFromCommunity \
                -list_args [list $community_id $user_id]

            # Get a few important things,
            # like rel_id and portal portal_id
            db_1row select_rel_info {}

            # Remove it
            relation_remove $rel_id

            # Remove the page
            portal::delete $portal_id
        }
    }

    ad_proc -public get_portal_id {
        community_id
        user_id
    } {
        Get the page ID for a particular community and user
    } {
        # BEN HACK
        return [db_string select_portal_id {} -default ""]
        # return [get_portal_template_id $community_id]
    }

    ad_proc -public get_community_non_members_portal_id {
        community_id
    } {
        Get the community page ID for non-members
    } {
        return [db_string select_community_portal_id {}]
    }

    ad_proc -public get_community_admin_portal_id {
        community_id
    } {
        Get the community Admin page ID
    } {
        return [db_string select_community_admin_portal_id {}]
    }

    ad_proc -public get_all_communities_by_user {
        user_id
    } {
        returns all communities for a user
    } {
        return [db_list_of_lists select_communities_by_user {}]
    }

    ad_proc -public get_communities_by_user {
        community_type
        user_id
    } {
        Return a datasource of the communities that a user belongs to in a particular type
    } {
        set list_of_communities [list]

        db_foreach select_communities {} {
            lappend list_of_communities [list $community_id $community_type $pretty_name $description [get_url -package_id $package_id]]
        }

        return $list_of_communities
    }

    ad_proc -public get_all_communities {
        community_type
    } {
        Returns a list of all communities, and whether or not they are active.
    } {
        return [db_list_of_lists select_all_communities {}]
    }

    ad_proc -public get_toplevel_community_type {
        {-community_type:required}
    } {
        returns the toplevel community_type which is the ancestor of this
        community_type
    } {
        return [db_string select_community_type {}]
    }

    ad_proc -public get_toplevel_community_type_from_community_id {
        community_id
    } {
        returns the community type from community_id
    } {
        set type [get_community_type_from_community_id $community_id]

        if {[string equal $type "dotlrn_community"] == 1} {
            return $type
        }

        return [db_string select_community_type {}]
    }

    ad_proc -public get_community_type_from_community_id {
        community_id
    } {
        returns the community type from community_id
    } {
        return [db_string select_community_type {}]
    }

    ad_proc -public get_community_type {
    } {
        Returns the community type key depending on the node we're at
    } {
        set package_id [ad_conn package_id]

        return [db_string select_community_type {} -default ""]
    }

    ad_proc -public get_community_id_from_url {
	{-url ""}
    } {
	returns the community from a URL
    } {
	if {[empty_string_p $url]} {
	    set url [ad_conn url]
	}

	set package_id [site_node_closest_ancestor_package -url $url dotlrn]

	return [get_community_id -package_id $package_id]
    }

    ad_proc -public get_community_id {
        {-package_id ""}
    } {
        Returns the community id depending on the package_id
        we're at, or the package_id passed in
    } {
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }

        return [db_string select_community {} -default ""]
    }

    ad_proc -public get_parent_community_id {
        {-package_id ""}
    } {
        Returns the community_id of our parent node or the parent
        of the passed in package_id. This is used for certain scripts
        under a dotlrn community, such as workflow panels, that cannot
        be passed their community_id.
    } {
        if {[empty_string_p $package_id]} {
            set package_id [ad_conn package_id]
        }

        set parent_pkg_id [site_nodes::get_parent_object_id \
                -instance_id $package_id
        ]

        return [get_community_id -package_id $parent_pkg_id]
    }

    ad_proc -public get_parent_id {
        {-community_id:required}
    } {
        Returns the parent community's id or null
    } {
        return [db_string select_parent_id {} -default ""]
    }

    ad_proc -public get_parent_name {
        {-community_id:required}
    } {
        Returns the parent community's name or null string
    } {
        set parent_id [get_parent_id -community_id $community_id]

        if {[empty_string_p $parent_id]} {
            return ""
        } else {
            return [get_community_name $parent_id]
        }
    }

    ad_proc -public check_community_key_valid_p {
        {-community_key:required}
        {-parent_community_id ""}
    } {
        Checks if the community_key passed in is valid for creating a new
        community by checking that it's not the same as an existing (possible)
        sibling's name.
    } {
        if {[db_0or1row collision_check {}]} {
            # got a collision
            return 0
        } else {
            return 1 
        }
    }

    ad_proc -public subcommunity_p {
        {-community_id:required}
    } {
        Returns 1 if the community is a subcommunity, else 0
    } {
        if {[empty_string_p [get_parent_id -community_id $community_id]]} {
            return 0
        } else {
            return 1
        }
    }

    ad_proc -public has_subcommunity_p {
        {-community_id:required}
    } {
        Returns 1 if the community has a subcommunity, memoized for 1 min
    } {
        return [util_memoize "dotlrn_community::has_subcommunity_p_memoized -community_id $community_id" 60]        
    }

    ad_proc -public has_subcommunity_p_memoized {
        {-community_id:required}
    } {
        Returns 1 if the community has a subcommunity
    } {
        return [db_0or1row select_subcomm_check {}]
    }


    ad_proc -public get_subcomm_list {
        {-community_id:required}
    } {
        Returns a tcl list of the subcommunities of this community or
        if none, the empty list
    } {
        return [db_list select_subcomms {}]
    }

    ad_proc -public get_subcomm_chunk {
        {-user_id ""}
        {-community_id:required}
        {-pretext "<li>"}
        {-join_target "register"}
        {-only_member_p 0}
    } {
        Returns a html fragment of the subcommunity hierarchy of this
        community or if none, the empty list.
        
        Brief notes: his proc always shows the subgroups of the
        passed-in group, but shows deeper groups _only if_ you are a
        member of all the supergroups to the leaf subgroup. Not even
        admins see the whole tree.

        FIXME: still rather slow

        things to get: has_subcom, member_p, url, name, admin_p, not_closed_p, member_pending, needs_approval
        things to send: user_id, sc_id, 
    } {
        set chunk ""

        if {[empty_string_p $user_id]} {
            set user_id [ad_get_user_id]
        }

        foreach sc_id [get_subcomm_list -community_id $community_id] {

            if {[has_subcommunity_p -community_id $sc_id] \
                    && [member_p $sc_id $user_id]} {
                # Shows the subcomms of this subcomm ONLY IF I'm a
                # member of the current comm
                set url [get_community_url $sc_id]
                append chunk \
                        "$pretext <a href=$url>[get_community_name $sc_id]</a>\n"
                
                if {[dotlrn::user_can_admin_community_p $sc_id]} {
                    append chunk \
                            "<small>\[<a href=${url}one-community-admin>admin</a>\]</small>"
                }

                append chunk \
                        "<ul>\n[get_subcomm_chunk -community_id $sc_id -user_id $user_id -only_member_p $only_member_p]</ul>\n"
            } elseif { [member_p $sc_id $user_id] \
                    || [dotlrn::user_can_admin_community_p $sc_id] \
                    || [not_closed_p -community_id $sc_id]} {
                # Shows the subcomm if: 
                # 1. I'm a member of this subcomm OR
                # 2. I'm have admin rights over the subcomm OR
                # 3. The subcomm has an "open" OR "request" join policy
                # but if the only_member_p flag is true, the user must be 
                # a member of the subcomm to see it.

                if {$only_member_p && ![member_p $sc_id $user_id]} {
                    continue
                }

                set url [get_community_url $sc_id]

                append chunk "$pretext <a href=$url>[get_community_name $sc_id]</a>\n"

                if {![member_p $sc_id $user_id]
                  && [not_closed_p -community_id $sc_id]} {

                      append chunk \
                          "<small>\["
                      
                      if {[member_pending_p -community_id $sc_id -user_id $user_id]} {
                          append chunk \
                              "waiting&nbsp;for&nbsp;approval"
                      } elseif {[needs_approval_p -community_id $sc_id]} {
                          append chunk \
                              "<a href=${url}${join_target}?referer=[ad_conn url]>request&nbsp;membership</a>"
                      } else {
                          append chunk \
                              "<a href=${url}${join_target}>join</a>"
                      }
                      
                      append chunk "\]</small>\n"
                }

                if {[dotlrn::user_can_admin_community_p $sc_id]} {
                    append chunk \
                            " <small>\[<a href=${url}one-community-admin>admin</a>\]</small>\n"
                }
            }
        }
        return $chunk
    }


    ad_proc -public get_subcomm_chunk_new {
        {-user_id ""}
        {-community_id:required}
        {-pretext "<li>"}
        {-join_target "register"}
        {-only_member_p 0}
    } {
        Returns a html fragment of the subcommunity hierarchy of this
        community or if none, the empty list.
        
        Brief notes: his proc always shows the subgroups of the
        passed-in group, but shows deeper groups _only if_ you are a
        member of all the supergroups to the leaf subgroup. Not even
        admins see the whole tree.

        more things to get from PL/SQL:   not_closed_p, member_pending, needs_approval
    } {
        set chunk ""

        if {[empty_string_p $user_id]} {
            set user_id [ad_get_user_id]
        }

        set referer [ad_conn url]

        db_foreach select_subcomm_info {} {
ns_log notice "XXX select dotlrn_community.member_p($sc_id, 2384) from dual;"
            if {$has_subcomm_p && $member_p} {
                # Shows the subcomms of this subcomm ONLY IF I'm a
                # member of the current comm
                append chunk "$pretext <a href=${url}>$name</a>\n"
                
                if {$admin_p} {
                    append chunk "<small>\[<a href=${url}one-community-admin>admin</a>\]</small>"
                }

                append chunk "<ul>\n[get_subcomm_chunk_new -community_id $sc_id -user_id $user_id -only_member_p $only_member_p]</ul>\n"
            } elseif { $member_p || $admin_p || [not_closed_p -community_id $sc_id]} {
                # Shows the subcomm if: 
                # 1. I'm a member of this subcomm OR
                # 2. I'm have admin rights over the subcomm OR
                # but if the only_member_p flag is true, the user must be 
                # a member of the subcomm to see it.

                if {$only_member_p && !$member_p} {
                    continue
                }

                append chunk "$pretext <a href=$url>$name</a>\n"

                if {!$member_p && [not_closed_p -community_id $sc_id]} {

                      append chunk "<small>\["
                      
                      if {[member_pending_p -community_id $sc_id -user_id $user_id]} {
                          append chunk "waiting&nbsp;for&nbsp;approval"
                      } elseif {[needs_approval_p -community_id $sc_id]} {
                          append chunk "<a href=\"${url}${join_target}?referer=${referer}\">request&nbsp;membership</a>"
                      } else {
                          append chunk "<a href=${url}${join_target}>join</a>"
                      }
                      
                      append chunk "\]</small>\n"
                }

                if {$admin_p} {
                    append chunk " <small>\[<a href=${url}one-community-admin>admin</a>\]</small>\n"
                }
            }
        }

        return $chunk
    }

    ad_proc -public get_community_type_url {
        community_type
    } {
        Get the URL for a community type
    } {
        return [get_url_from_package_id -package_id [get_community_type_package_id $community_type]]
    }

    ad_proc -public get_community_url {
        community_id
    } {
        Get the URL for a community
    } {
        return [get_url_from_package_id -package_id [get_package_id $community_id]]
    }

    ad_proc -public get_community_type_package_id {
        community_type
    } {
        get the package id for a particular community type
    } {
        return [db_string select_package_id {} -default ""]
    }

    ad_proc -public get_package_id {
        community_id
    } {
        get the package ID for a particular community
    } {
        return [db_string select_package_id {} -default ""]
    }

    ad_proc -public get_applet_package_id {
        community_id
        applet_key
    } {
        get the package ID for a particular community
    } {
        return [db_string select_package_id {} -default ""]
    }

    ad_proc -public get_community_type_name {
        community_type
    } {
        get the name for a community type
    } {
        return [db_string select_community_type_name {} -default ""]
    }

    ad_proc -public get_community_name {
        community_id
    } {
        get the name for a community
    } {
        return [util_memoize "dotlrn_community::get_community_name_memoized $community_id"]
    }

    ad_proc -public get_community_name_memoized {
        community_id
    } {
        memo helper
    } {
        return [db_string select_community_name {} -default ""]
    }

    ad_proc -public get_community_header_name {
        community_id
    } {
        get the name for a community for the header
    } {
        if {[subcommunity_p -community_id $community_id]} {
            set parent_name [get_parent_name -community_id $community_id]
            return [concat "<a href=\"..\">$parent_name</a> : [get_community_name $community_id]"]
        } else {
            return [get_community_name $community_id]
        }
    }

    ad_proc -public get_community_description {
        community_id
    } {
        get the description for a community
    } {
        return [db_string select_community_description {} -default ""]
    }

    ad_proc -public get_community_key {
        {-community_id:required}
    } {
        Get the key for a community
    } {
        return [db_string select_community_key {} -default ""]
    }

    ad_proc -public not_closed_p {
        {-community_id:required}
    } {
        returns 1 if the community's join policy is not closed
    } {
        return [db_0or1row check_community_not_closed {}]
    }

    ad_proc -public open_p {
        {-community_id:required}
    } {
        returns 1 if the community's join policy is 'open'
    } {
        return [db_0or1row check_community_open {}]
    }

    ad_proc -public needs_approval_p {
        {-community_id:required}
    } {
        returns 1 if the community's join policy is 'needs approval' aka "request approval"
    } {
        return [db_0or1row check_community_needs_approval {}]
    }

    ad_proc -public get_portal_template_id {
        {community_id ""}
    } {
        get the id of the portal template for a community
    } {
        if {[empty_string_p $community_id]} {
            set community_id [get_community_id]
        }

        return [db_string select_portal_template_id {} -default ""]
    }

    ad_proc -public add_applet_to_community {
        community_id
        applet_key
    } {
        Adds an applet to the community
    } {
        db_transaction {
            # Callback
            set package_id [applet_call $applet_key AddAppletToCommunity [list $community_id]]

            set applet_id [dotlrn_applet::get_applet_id_from_key -applet_key $applet_key]
            # auto activate for now
            set active_p "t"

            # Insert in the DB
            db_dml insert {}

            # Go through current users and make sure they are added!
            foreach user [list_users $community_id] {
                set user_id [ns_set get $user user_id]

                # do the callbacks
                applet_call $applet_key AddUserToCommunity [list $community_id $user_id]
            }
        }
    }


    ad_proc -public remove_applet {
        community_id
        applet_key
    } {
        Removes an applet from a community
    } {
        # Get the package_id
        set package_id [get_package_id $community_id]

        db_transaction {
            # Take care of all existing users
            foreach user [list_users $community_id] {
                set user_id [ns_set get $user user_id]

                # do the callbacks
                applet_call $applet_key RemoveUserFromCommunity [list $community_id $user_id]
            }

            # Callback
            applet_call $applet_key RemoveApplet [list $community_id $package_id]

            # Delete from the DB
            db_dml delete_applet {}
        }
    }

    ad_proc -public delete {
        {-community_id ""}
    } {
        Delete a community
    } {
        db_transaction {
            # Remove all users
            foreach user [list_users $community_id] {
                remove_user $community_id [ns_set get $user user_id]
            }
            
            # Remove all applets
            foreach applet [list_applets -community_id $community_id] {
                remove_applet $community_id $applet
            }
            
            # Clean up
            db_1row select_things_to_clean "select portal_id, admin_portal_id, portal_template_id, package_id from dotlrn_communities where community_id= :community_id"

            # Remove the row
            db_exec_plsql remove_community "begin acs_object.delete(:community_id) end;"

            if {![empty_string_p $portal_id]} {
                portal::delete $portal_id
            }
            
            if {![empty_string_p $admin_portal_id]} {
                portal::delete $admin_portal_id
            }

            if {![empty_string_p $portal_template_id]} {
                portal::delete $portal_template_id
            }

            # Remove the package
            db_exec_plsql delete_package "begin acs_object.delete(:package_id) end;"
        }
    }

    ad_proc -public list_applets {
        {-community_id ""}
    } {
        Lists the applets associated with a community or all the dotlrn applets
    } {
        if {[empty_string_p $community_id]} {
            # List all applets
            return [db_list select_all_applets {}]
        } else {
            # List from the DB
            return [db_list select_community_applets {}]
        }
    }

    ad_proc -public list_active_applets {
        {-community_id ""}
    } {
        Lists the applets associated with a community or only the active dotlrn
        applets
    } {
        if {[empty_string_p $community_id]} {
            # List all applets
            return [db_list select_all_active_applets {}]
        } else {
            # List from the DB
            return [db_list select_community_active_applets {}]
        }
    }

    ad_proc -public applet_active_p {
        {-community_id:required}
        {-applet_key:required}
    } {
        Is this applet active in this community? Does it do voulunteer work?
        Helps its neighbors? <joke> returns 1 or 0
    } {
        return [db_0or1row select_active_applet_p {}]
    }

    ad_proc -public applets_dispatch {
        {-community_id ""}
        {-op:required}
        {-list_args {}}
        {-reorder_hack_p ""}
    } {
        Dispatch an operation to every applet, either in one communtiy or
        on all the active dotlrn applets
    } {
        set list_of_applets [list_active_applets -community_id $community_id]

        if {![empty_string_p $reorder_hack_p]} { 
            ns_log notice "aks1: applets_dispatch: reorder hack!"

            set reorder_applets_string [ad_parameter user_wsp_applet_ordering "dotlrn" "dotlrn_news,dotlrn_bboard,dotlrn_survey,dotlrn_faq"]

            set reorder_applets_list [string trim [split $reorder_applets_string {,}]]
            
            # check if the applet is both in the reorder list and the applet list
            # if so, put it into the right place in the result list
            # if not, skip it
            set result_list [list]
            foreach applet $reorder_applets_list {
                set index [lsearch -exact $list_of_applets $applet]

                if {$index != -1 } {
                    ns_log notice "aks2: reorder HIT with '$applet' against '$list_of_applets' // $index"
                    set list_of_applets [lreplace $list_of_applets $index $index]
                    lappend result_list $applet
                } else {
                    ns_log notice "aks3: reorder MISS with '$applet' against '$list_of_applets'"
                }
            }

            set list_of_applets [concat $result_list $list_of_applets]
        }


        foreach applet $list_of_applets {
            # Callback on applet
            applet_call $applet $op $list_args
        }
    }

    ad_proc -public applet_call {
        applet_key
        op
        {list_args {}}
    } {
        Call a particular applet op
    } {
        acs_sc_call dotlrn_applet $op $list_args $applet_key
    }

}

