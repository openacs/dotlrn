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

ad_page_contract {
    Add an applet to a community

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-08
} -query {
    community_id
    applet_key
}

# Check access
if {![dotlrn_community::admin_access_p $community_id]} {
    ns_returnredirect /
    return
}

# Add the applet
dotlrn_community::remove_applet $community_id $applet_key

# Get back to where you once belonged
ns_returnredirect community-applets?community_id=$community_id
