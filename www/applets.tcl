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
    Manage the Applets for this community

    @author yon (yon@openforce.net)
    @creation-date 2002-01-19
    @version $Id$
} -query {
}

set community_id [dotlrn_community::get_community_id]
set user_id [ad_get_user_id]
set portal_id [dotlrn_community::get_portal_id $community_id $user_id]

set context_bar {{"one-community-admin" Admin} {Manage Applets}}
