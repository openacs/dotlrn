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

# dotlrn/www/admin/clubs.tcl

ad_page_contract {
    displays dotLRN clubs admin page

    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    clubs:multirow
}

set title [parameter::get -localize -parameter clubs_pretty_plural]
set context_bar [list $title]

db_multirow clubs select_clubs {} {
    set description [ad_quotehtml $description]
}

# Some of the en_US messages in the adp use these variables
set clubs_pretty_name [parameter::get -localize -parameter clubs_pretty_name]
set clubs_pretty_plural [parameter::get -localize -parameter clubs_pretty_plural]

ad_return_template
