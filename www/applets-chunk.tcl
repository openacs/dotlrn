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
    Community Applets

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-05
    @version $Id$
} -query {
}

set community_id [dotlrn_community::get_community_id]

# this chunk must be restricted to admins of the community only
dotlrn::require_user_admin_community \
    -user_id [ad_conn user_id] \
    -community_id $community_id

# Get active applets
set list_of_active_applets [dotlrn_community::list_active_applets -community_id $community_id]

template::multirow create active_applets applet_key applet_pretty_name

foreach applet_key $list_of_active_applets {
    template::multirow append active_applets $applet_key [dotlrn_community::applet_call $applet_key GetPrettyName]
}

# List all applets
set list_of_applets [dotlrn_applet::list_applets]

template::multirow create all_applets applet_key applet_pretty_name

foreach applet_key $list_of_applets {
    if {[lsearch $list_of_active_applets $applet_key] == -1} {
	template::multirow append all_applets $applet_key [dotlrn_community::applet_call $applet_key GetPrettyName]
    }
}

ad_return_template

