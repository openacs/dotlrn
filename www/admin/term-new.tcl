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

ad_page_contract {
    create a new term - input form

    @author yon (yon@openforce.net)
    @creation-date 2001-12-13
    @version $Id$
} -query {
    {referer "terms"}
} -properties {
    context_bar:onevalue
}

form create add_term

element create add_term term_name \
    -label "Term (e.g. Spring, Fall)" \
    -datatype text \
    -widget text \
    -html {size 30}

element create add_term term_year \
    -label "Year" \
    -datatype text \
    -widget text \
    -html {size 5 maxsize 4}

element create add_term start_date \
    -label "Start Date" \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY}

element create add_term end_date \
    -label "End Date" \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY}

element create add_term referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_term]} {
    form get_values add_term \
        term_name term_year start_date end_date referer

    dotlrn_term::new \
        -term_name $term_name \
        -term_year $term_year \
        -start_date $start_date \
        -end_date $end_date

    ad_returnredirect $referer
    ad_script_abort
}

set context_bar {{terms Terms} New}

ad_return_template
