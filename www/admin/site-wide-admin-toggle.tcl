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

# dotlrn/www/admin/site-wide-admin-toggle.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 12, 2002
    @version $Id$
} -query {
    user_id
    value
    {referer "users"}
}

if {[string equal $value "grant"] == 1} {
    ad_permission_grant $user_id [acs_magic_object "security_context_root"] "admin"
} elseif {[string equal $value "revoke"] == 1} {
    ad_permission_revoke $user_id [acs_magic_object "security_context_root"] "admin"
}

ad_returnredirect $referer
