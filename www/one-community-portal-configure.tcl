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

    Displays a configuration page for COMMUNITY'S portal ONLY!
    This page is restricted to admins of the community.

    User portals are configured by the configure.tcl page.

    @author Arjun Sanyal (arjun@openforce.net)
    @version $Id$
} -query {
    {referer "one-community-admin"}
}

dotlrn::require_user_admin_community \
    -user_id [ad_conn user_id] \
    -community_id [dotlrn_community::get_community_id]

set rendered_page [portal::configure \
    [dotlrn_community::get_portal_id] \
    $referer
]

ad_return_template
