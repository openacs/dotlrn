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

# dotlrn/www/user-add.tcl

ad_page_contract {
    adding a user by an administrator

    @author yon (yon@openforce.net)
    @creation-date 2002-01-19
    @version $Id$
} -query {
    {type student}
    {can_browse_p 1}
    {read_private_data_p t}
    {add_membership_p t}
    {dotlrn_interactive_p 0}
    {referer members}
} -properties {
    context_bar:onevalue
}

set current_user_id [ad_maybe_redirect_for_registration]
set community_id [dotlrn_community::get_community_id]

if {![empty_string_p $community_id]} {
    dotlrn::require_user_admin_community -community_id [dotlrn_community::get_community_id]
    set context_bar [list [list "one-community-admin" [_ dotlrn.Admin]] [_ dotlrn.Add_User]]
    set community_p 1
} else {
    dotlrn::require_admin
    set context_bar [list [list users [_ dotlrn.Users]] [_ dotlrn.Add_User]]
    set community_p 0
}

# Export dotlrn-specific vars in the next_url
set next_url [export_vars -base user-add-2 {type can_browse_p read_private_data_p add_membership_p dotlrn_interactive_p referer}]
