#
#  Copyright (C) 2001, 2002 MIT
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

ad_page_contract {
    deregister

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-06
    @version $Id$
} -query {
    {user_id:multiple,integer ""}
    {community_id ""}
    {referer "./"}
}


# This page was modified to allow more that one user to be dropped at a time.
# This one done so there is one consistent way of dropping members.
#
# The parameter "user_id" was kept so that other entry points (both current
# and those that might occur in the future from OpenACS and other changes)
# wouldn't break.  This does have the unfortunate consequence that the name
# user_id is not intuative when it is a list of many user_ids. (teadams@alum.mit.edu)

ad_maybe_redirect_for_registration

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

if {[empty_string_p $user_id]} {
    set user_id [ad_conn user_id]
} else {
    dotlrn::require_user_admin_community -community_id $community_id
}

foreach member_id $user_id {
 
    # This is catch most double clicks.
    # The catch will take care of cases where the double click is too fast.

    if {[dotlrn_community::member_p $community_id $member_id]} {
	if {[catch {
	    dotlrn_community::remove_user $community_id $member_id
	} errmsg]} {

	    if {![dotlrn_community::member_p $community_id $user_id]} {
		# assume this was a double click
		ad_returnredirect $referer
		ad_script_abort
	    } else {
		ns_log Error "deregister.tcl failed: $errmsg"
		ReturnHeaders
		ad_return_error "Error removing user community"  "An error occured while trying to remove a user to a community.  This error has been logged."
	    }
	}
    }
}

ad_returnredirect $referer
