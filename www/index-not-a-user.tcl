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

# dotlrn/www/index-not-a-user.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Dec 11, 2001
    @version $Id$
} -query {
} -properties {
    admin_p:onevalue
    admin_url:onevalue
}

set admin_p [dotlrn::admin_p]
set admin_url [dotlrn::get_url]/admin
set admin_pretty_name [parameter::get -localize -parameter dotlrn_admin_pretty_name]

ad_return_template

