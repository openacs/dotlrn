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
    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {section ""}
} -properties {
    user_id:onevalue
}

set oacs_site_wide_admin_p [acs_user::site_wide_admin_p]
set user_id [ad_conn user_id]

if {![exists_and_not_null referer]} {
    set referer "[dotlrn::get_admin_url]/users"
}

ad_return_template

