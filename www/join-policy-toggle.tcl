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
    Change the join policy of a dotLRN community.

    @author yon (yon@openforce.net)
    @creation-date 2002-01-18
    @version $Id$
} -query {
    {community_id ""}
    policy:notnull
    {referer "one-community-admin"}
} -validate {
    policy_ck -requires {policy:notnull} {
        if {!(
            [string equal $policy "open"] == 1 ||
            [string equal $policy "needs approval"] == 1 ||
            [string equal $policy "closed"] == 1
        )} {
            ad_complain [_ dotlrn.lt_policy_must_be_one_of]
        }
    }
}

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_admin_community -community_id $community_id

db_dml update_join_policy {}

ad_returnredirect $referer

