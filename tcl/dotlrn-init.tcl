

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

# We go through all Applets and make sure they are added.

# The applet_add proc in the dotlrn_applet contract is for one-time
# init of each applet NOTE: this applet_add proc _must_ be able to be
# called repeatedly since this script is eval'd at every server startup
# - aks

foreach applet [dotlrn_community::list_applets] {
    # Callback on all applets
    dotlrn_community::applet_call $applet "AppletAdd" [list]
}

# We check to see if dotLRN has been installed, and if so, if permissions
# have been granted

set main_package_id [dotlrn::get_package_id]

# if installed
if {![empty_string_p $main_package_id]} {
    # Grantee
    set grantee_id [dotlrn::get_full_users_rel_segment_id]

    # Grant the permission
    if {![ad_permission_p -user_id $grantee_id $main_package_id dotlrn_browse]} {
	ad_permission_grant $grantee_id $main_package_id dotlrn_browse
    }
}

# Make sure that privacy is turned on
acs_privacy::privacy_control_set 1

