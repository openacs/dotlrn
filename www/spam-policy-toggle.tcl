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
    @cvs-id $Id$
} -query {
    {community_id:integer ""}
    policy:notnull
    {referer:localurl "one-community-admin"}
} -validate {
    policy_ck -requires {policy:notnull} {
        if { $policy ni {all admins} } {
            ad_complain [_ dotlrn.lt_spam_policy_must_be_o]
        }
    }
}

if {$community_id eq ""} {
    set community_id [dotlrn_community::get_community_id]
}

dotlrn::require_user_admin_community -community_id $community_id

if {$policy eq "all"} {
    set action "grant"
} else {
    set action "revoke"
}

permission::$action -party_id [dotlrn_community::get_members_rel_id -community_id $community_id] \
    -object_id $community_id -privilege dotlrn_spam_community

ad_returnredirect $referer
ad_script_abort

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
