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
    Change the spam policy of a dotLRN community.

    @author Don Baccus (dhogaza@pacifier.com)
    @creation-date 2002-01-18
    @version $Id$
} -query {
    {community_id ""}
    policy:notnull
    {referer "one-community-admin"}
} -validate {
    policy_ck -requires {policy:notnull} {
        if {!(
            [string equal $policy "all"] == 1 ||
            [string equal $policy "admins"] == 1
        )} {
            ad_complain {spam policy must be one of: all or members}
        }
    }
}

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_admin_community -community_id $community_id

if { [string equal $policy all] } {
    set action "grant"
} else {
    set action "revoke"
}

permission::$action -party_id [dotlrn_community::get_members_rel_id -community_id $community_id] \
    -object_id $community_id -privilege dotlrn_spam_community

# Make sure we flush everything that references this community and the spam privilege
util_memoize_flush_regexp "${community_id}(.*)dotlrn_spam_community"

ad_returnredirect $referer
