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
    Search for a new user for dotLRN

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @author Hector Amado (hr_amado@galileo.edu)
    @creation-date 2004-07-02
    @cvs-id $Id$
} -query {
    search_text
    {referer "dotlrn-admins"}
}

set search_text [string trim $search_text]
set community_id [dotlrn_community::get_community_id]

# Just search
db_multirow users select_users {}

set context_bar [list [list "dotlrn-admins" [_ dotlrn.Admin]] [_ dotlrn.New_User]]

ad_return_template

