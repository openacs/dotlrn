#
# Procs for DOTLRN Community Management
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# Started: September 28th, 2001
# ben@openforce.net, arjun@openforce.net
#
# $Id$
#

ad_library {

    Procs to manage DOTLRN Communities

    @author ben@openforce.net
    @author arjun@openforce.net
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
    } {
        create base community_type for dotlrn_community type
    } {
        db_transaction {
            if {![dotlrn::is_instantiated_here -url "[dotlrn::get_url]/${community_type_url_part}/"]} {
                set package_id [dotlrn::mount_package \
                    -package_key [dotlrn::package_key] \
                    -url $community_type_url_part \
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

    ad_proc -public new {
        {-description ""}
        {-community_type:required}
        {-object_type "dotlrn_community"}
        {-community_key:required}
        {-pretty_name:required}
        {-extra_vars ""}
    } {
        create a new community
    } {
        # Set up extra vars
        if {[empty_string_p $extra_vars]} {
            set extra_vars [ns_set create]
        }

        # Add core vars
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

            # Create portal template page
            set portal_template_id \
                    [portal::create \
                    -portal_template_p "t" \
                    -name "$pretty_name Portal Template" \
                    -context_id $community_id \
                    $user_id ]

            # Create the non-member page
            set portal_id \
                    [portal::create \
                    -template_id $portal_template_id \
                    -name "$pretty_name Non-Member Portal" \
                    -context_id $community_id \
                    $user_id]

            # update the portal_template_id and non_member_portal_id
            db_dml update_portal_ids {}

            # Set up the rel segments
            dotlrn_community::create_rel_segments -community_id $community_id

            # Set up the node
            set parent_node_id [get_type_node_id $community_type]

            # Create the node
            set new_node_id [site_node_create $parent_node_id $community_key]

            # Instantiate the package
            set package_id [site_node_create_package_instance $new_node_id $pretty_name $community_id [one_community_package_key]]

            # Set the right parameters
            ad_parameter -package_id $package_id -set 0 dotlrn_level_p
            ad_parameter -package_id $package_id -set 0 community_type_level_p
            ad_parameter -package_id $package_id -set 1 community_level_p

            # Set up the node
            dotlrn_community::set_package_id $community_id $package_id

            # Assign proper permissions to the site node
            # NOT CERTAIN what to do here yet
        }

        return $community_id
    }

    ad_proc set_active_dates {
        {-community_id:required}
        {-start_date:required}
        {-end_date:required}
    } {
        set the community active ebgin and end dates
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
        { -community_type "" }
        { -community_id "" }
    } {
        if {[empty_string_p $community_type]} {
            set community_type [get_toplevel_community_type_from_community_id $community_id]
        }

        if {$community_type == "dotlrn_class_instance"} {
            return {
                {dotlrn_student_rel Student}
                {dotlrn_ta_rel TA}
                {dotlrn_instructor_rel Instructor}
                {dotlrn_admin_rel Admin}
            }
        }

        if {$community_type == "dotlrn_club"} {
            return {
                {dotlrn_member_rel Member}
                {dotlrn_admin_rel Admin}
            }
        }

        return {}
    }

    ad_proc -public get_pretty_rel_type {
        rel_type
    } {
        Returns a pretty version of the rel_type
    } {
        set pretty_name [db_string select_pretty_name "select pretty_name from acs_object_types where object_type=:rel_type"]
        return $pretty_name
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
            ad_permission_grant $member_segment_id $community_id read
            ad_permission_grant $member_segment_id $community_id write
            ad_permission_grant $admin_segment_id $community_id admin
        }
    }

    ad_proc -public delete_rel_segments {
        {-community_id:required}
    } {
        remove the rel segments for a community
    } {
        # Take care of the admins
        set admin_segment_id [get_rel_segment_id -community_id $community_id -rel_type dotlrn_admin_rel]
        ad_permission_revoke $admin_segment_id $community_id admin
        rel_segments_delete $admin_segment_id

        # Take care of the members
        set member_segment_id [get_rel_segment_id -community_id $community_id -rel_type dotlrn_member_rel]
        ad_permission_revoke $member_segment_id $community_id edit
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
        return [db_list_of_lists select_users {}]
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
        {-rel_type "dotlrn_member_rel"}
        community_id
        user_id
    } {
        add a user to a particular community
    } {
        if {[string equal [get_toplevel_community_type_from_community_id $community_id] "dotlrn_class_instance"]} {
            dotlrn_class::add_user -rel_type $rel_type -community_id $community_id -user_id $user_id
        } elseif {[string equal [get_toplevel_community_type_from_community_id $community_id] "dotlrn_club"]} {
            dotlrn_club::add_user -rel_type $rel_type -community_id $community_id -user_id $user_id
        } else {
            add_user_to_community -rel_type $rel_type -community_id $community_id -user_id $user_id
        }
    }

    ad_proc -public add_user_to_community {
        {-rel_type "dotlrn_member_rel"}
        {-community_id:required}
        {-user_id:required}
        {-extra_vars ""}
    } {
        Assigns a user to a particular role for that class. Roles in DOTLRN can be student, prof, ta, admin
    } {
        db_transaction {
            # Set up a portal page for that user and that community
            set portal_id [portal::create \
                    -name "Your [get_community_name $community_id] page" \
                    -template_id [get_portal_template_id $community_id] \
                    $user_id]

            # Create the form with the portal_id
            if {[empty_string_p $extra_vars]} {
                set extra_vars [ns_set create]
            }
            ns_set put $extra_vars portal_id $portal_id
            ns_set put $extra_vars user_id $user_id
            ns_set put $extra_vars community_id $community_id

            # Set up the relationship
            set rel_id [relation_add -extra_vars $extra_vars $rel_type $community_id $user_id]

            # do the callbacks
            applets_dispatch $community_id AddUserToCommunity [list $community_id $user_id]
        }
    }

    ad_proc -public remove_user {
        community_id
        user_id
    } {
        Removes a user from a class
    } {
        db_transaction {
            # Callbacks
            applets_dispatch $community_id RemoveUser [list $community_id $user_id]

            # Get a few important things, like rel_id and portal portal_id
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
        return [db_string select_portal_id {}]
    }

    ad_proc -public get_community_non_members_portal_id {
        community_id
    } {
        Get the community page ID for non-members
    } {
        return [db_string select_community_portal_id {}]
    }

    ad_proc -public get_all_communities_by_user {
        user_id
    } {
        returns all communities for a user
    } {
        set return_list [db_list_of_lists select_communities_by_user {}]

        ns_log Notice "return list: $return_list"

        return $return_list
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

    ad_proc -public get_toplevel_community_type_from_community_id {
        community_id
    } {
        returns the community type from community_id
    } {
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

    ad_proc -public get_community_id {
    } {
        Returns the community id depending on the node we're at
    } {
        set package_id [ad_conn package_id]

        return [db_string select_community {} -default ""]
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
        return [db_string select_community_name {} -default ""]
    }

    ad_proc -public get_portal_template_id {
        community_id
    } {
        get the id of the portal template for a community
    } {
        return [db_string select_portal_template_id {} -default ""]
    }

    ad_proc -public add_applet {
        community_id
        applet_key
    } {
        Adds an applet to the community
    } {
        db_transaction {
            # Callback
            set package_id [applet_call $applet_key AddAppletToCommunity [list $community_id]]

            # Insert in the DB
            db_dml insert_applet {}            

            # Go through current users and make sure they are added!
            foreach user [list_users $community_id] {
                set user_id [lindex $user 2]

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
                set user_id [lindex $user 2]

                # do the callbacks
                applet_call $applet_key RemoveUser [list $community_id $user_id]
            }

            # Callback
            applet_call $applet_key RemoveApplet [list $community_id $package_id]

            # Delete from the DB
            db_dml delete_applet {}
        }
    }

    ad_proc -public list_applets {
        {community_id ""}
    } {
        Lists the applets associated with a community
    } {
        if {[empty_string_p $community_id]} {
            # List all applets
            return [db_list select_all_applets {}]
        } else {
            # List from the DB
            return [db_list select_community_applets {}]
        }
    }

    ad_proc -public applets_dispatch {
        community_id
        op
        list_args
    } {
        Dispatch an operation to every applet
    } {
        foreach applet [list_applets $community_id] {
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
