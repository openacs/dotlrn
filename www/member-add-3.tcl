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
    Add the new user

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    user_id
    rel_type
    {referer "one-community-admin"}
}

#prevent this page from being called when it is not allowed
# i.e.   AllowManageMembership 0
dotlrn_portlet::is_allowed -parameter managemembership

set community_id [dotlrn_community::get_community_id]
# See if the user is already in the group
set member_p [dotlrn_community::member_p $community_id $user_id]

if {$member_p} {
    dotlrn_community::remove_user $community_id $user_id
}


# Add the relation
dotlrn_community::add_user -rel_type $rel_type $community_id $user_id

ad_returnredirect $referer

