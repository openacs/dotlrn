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
    Displays dotLRN departments admin page

    @author yon (yon@openforce.net)
    @creation-date 2002-01-20
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    departments:multirow
}

set title [parameter::get -localize -parameter departments_pretty_plural]
set context_bar [parameter::get -localize -parameter departments_pretty_plural]
set referer departments
set can_create [dotlrn_class::can_create]
set departments_pretty_name [parameter::get -localize -parameter departments_pretty_name]
set departments_pretty_plural [parameter::get -localize -parameter departments_pretty_plural]
set classes_pretty_name [parameter::get -localize -parameter classes_pretty_name]

db_multirow departments select_departments {}

ad_return_template

