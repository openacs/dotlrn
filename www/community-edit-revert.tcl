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

    Revert the properties for a community

    @author <a href="mailto:arjun@openforce.net">arjun@openforce.net</a>
    @version $Id$

} -query {
    {referer "community-edit"}
}

set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]
dotlrn::require_user_admin_community -user_id $user_id $community_id

# blow way all the attributes
dotlrn_community::unset_attributes \
    -community_id $community_id

ad_returnredirect $referer
