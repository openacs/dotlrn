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

ns_log notice "dotlrn-init: starting..."

# if installed
if {[dotlrn::is_instantiated]} {

    set portal_package_key [portal::package_key]
    set portal_mount_point [portal::automount_point]
    
    # we now mount new-portal at the automount point if it's not already mounted, of course 
    if {[site_nodes::mount_count -package_key $portal_package_key] == 0} {
        
        ns_log notice "dotlrn-init: $portal_package_key being automounted at /$portal_mount_point"
        
        dotlrn::mount_package \
                -parent_node_id [site_node_id "/"] \
                -package_key $portal_package_key \
                -url $portal_mount_point \
                -directory_p "t"
    }


    # aks debug
    db_transaction {
    
        ns_log notice "dotlrn-init: dotlrn is instantiated, about to call dotlrn_applet::init"
    
        # this may seems strange, but init the applets first - aks
        # initialize the applets subsystem (ooh, I'm using big words - ben)
        if {![dotlrn_applet::is_initalized]} { dotlrn_applet::init }
    
        # We go through all Applets and make sure they are added.
    
        # The applet_add proc in the dotlrn_applet contract is for one-time
        # init of each applet NOTE: this applet_add proc _must_ be able to be
        # called repeatedly since this script is eval'd at every server startup
        # - aks
        foreach applet [dotlrn_community::list_applets] {
            # Callback on all applets
            dotlrn_community::applet_call $applet "AddApplet" [list]
        }
    
        ns_log notice "dotlrn-init: dotlrn is instantiated, about to call dotlrn::init"
    
        if {![dotlrn::is_initialized]} { dotlrn::init }
    
        ns_log notice "dotlrn-init: about to call dotlrn_class:init"
    
        if {![dotlrn_class::is_initialized]} { dotlrn_class::init }
    
        ns_log notice "dotlrn-init: about to call dotlrn_club::init"
    
        if {![dotlrn_club::is_initialized]} { dotlrn_club::init }
    
        ns_log notice "dotlrn-init: done with dotlrn_club::init"
    
        # Grantee
        set grantee_id [dotlrn::get_full_users_rel_segment_id]
        set package_id [dotlrn::get_package_id]
    
        # Grant the permission
        permission::grant -party_id $grantee_id -object_id $package_id -privilege "dotlrn_browse"
    
        # check read permission on dotLRN for all users
        set grantee_id [dotlrn::get_users_rel_segment_id]
        permission::grant -party_id $grantee_id -object_id $package_id -privilege "read"

    }
}


# Make sure that privacy is turned on
acs_privacy::privacy_control_set 1

ns_log notice "dotlrn-init: done"
