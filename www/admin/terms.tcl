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

# dotlrn/www/admin/terms.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Dec 13, 2001
    @version $Id$
} -query {
} -properties {
    context_bar:onevalue
    terms:multirow
}

set context_bar "[_ dotlrn.Terms]"

db_multirow -extend { start_date_pretty end_date_pretty } terms select_terms {} {
    set start_date_pretty [lc_time_fmt $start_date_ansi "%q"]
    set end_date_pretty [lc_time_fmt $end_date_ansi "%q"]
}

ad_return_template

