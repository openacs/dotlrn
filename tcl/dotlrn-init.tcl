#
# Procs for initializing DOTLRN basic system
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# August 20th, 2001
#

ad_library {
    
    Procs for initializing basic dotLRN
    
    @author ben@openforce.net
    @creation-date 2001-08-18
    
}

# We check to see if dotLRN has been installed, and if so, if permissions
# have been granted

ns_log notice "aks: dotlrn-init: starting"

# if installed
if {[dotlrn::is_instantiated]} {
    ns_log notice "aks: dotlrn-init: got here 1"

    if {![dotlrn::is_initialized]} { dotlrn::init }

    ns_log notice "aks: dotlrn-init: got here 2"

    if {![dotlrn_class::is_initialized]} { dotlrn_class::init }

    ns_log notice "aks: dotlrn-init: got here 3"

    if {![dotlrn_club::is_initialized]} { dotlrn_club::init }

    ns_log notice "aks: dotlrn-init: got here 4"

    # Grantee
    set grantee_id [dotlrn::get_full_users_rel_segment_id]
    set package_id [dotlrn::get_package_id]

    # Grant the permission
    ad_permission_grant $grantee_id $package_id dotlrn_browse

    # check read permission on dotLRN for all users
    set grantee_id [dotlrn::get_users_rel_segment_id]
    ad_permission_grant $grantee_id $package_id read

    # We go through all Applets and make sure they are added.

    # The applet_add proc in the dotlrn_applet contract is for one-time
    # init of each applet NOTE: this applet_add proc _must_ be able to be
    # called repeatedly since this script is eval'd at every server startup
    # - aks
    foreach applet [dotlrn_community::list_applets] {
        # Callback on all applets
        dotlrn_community::applet_call $applet "AddApplet" [list]
    }

    set portal_package_key "new-portal"
    if {[site_nodes::mount_count -package_key $portal_package_key] == 0} {
        ns_log notice "aks: dotlrn-init: new-portal being automounted"

        dotlrn::mount_package -parent_node_id [site_node_id "/"] -package_key $portal_package_key -url "portal" -directory_p "t"
    } else {
        ns_log notice "aks: dotlrn-init: new-portal NOT being automounted"
    }

}

# Make sure that privacy is turned on
acs_privacy::privacy_control_set 1
