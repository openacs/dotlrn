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

# dotlrn/www/preferences.tcl

ad_page_contract {
    Preferences for dotLRN

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-10
    @version $Id$
} -query {
} -properties {
    title:onevalue
    admin_p:onevalue
    admin_url:onevalue
    referer:onevalue
}

set portal_id [dotlrn::get_workspace_portal_id [ad_get_user_id]]

# Make sure user is logged in
set user_id [ad_maybe_redirect_for_registration]

set title "Preferences"
set admin_p [dotlrn::admin_p]
set admin_url "[dotlrn::get_url]/admin"
set referer [ns_conn url]
set admin_pretty_name [ad_parameter "dotlrn_admin_pretty_name"]

ad_return_template
