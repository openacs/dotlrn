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

    Displays a configuration page for user's portal ONLY!

    Community portals are configured by the one-community-portal-configure
    page.

    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-24
    @version $Id$

}

if {[parameter::get -parameter community_type_level_p] == 1} {

    # at a community type level, redirect
    ad_returnredirect "one-community-type"
    return

} elseif {[parameter::get -parameter community_level_p] == 1} {

    # at a community, only admins can configure a comm's portal
    ad_returnredirect "one-community"
    return

} else {
    set user_id [ad_conn user_id]

    # I don't see under what circumstance we wouldn't want users to
    # customize thier own portal. -Caroline.

    #    dotlrn::require_user_browse -user_id $user_id

    set portal_id [dotlrn::get_portal_id -user_id $user_id]
    set name [portal::get_name $portal_id]
    set rendered_page [portal::configure -allow_theme_change_p 0 $portal_id "index"]
}

ad_return_template

