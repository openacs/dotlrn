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
    edit a term

    @author yon (yon@openforce.net)
    @creation-date 2002-03-14
    @version $Id$
} -query {
    term_id:integer,notnull
    {referer "terms"}
} -properties {
    context_bar:onevalue
}

if {![db_0or1row select_term_info {}]} {
    ad_return_complaint 1 "<li>Invalid term_id $term_id</li>"
    ad_script_abort
}

set referer "term?[ns_conn query]"
set context_bar [list [list terms Terms] [list $referer "$term_name $term_year"] Edit]

form create edit_term

element create edit_term term_id \
    -label "Term ID" \
    -datatype integer \
    -widget hidden \
    -value $term_id

element create edit_term term_name \
    -label "Term (e.g. Spring, Fall)" \
    -datatype text \
    -widget text \
    -html {size 30}

element create edit_term term_year \
    -label "Year (e.g. 2003, 2003/2004)" \
    -datatype text \
    -widget text \
    -html {size 9 maxlength 9}

element create edit_term start_date \
    -label "Start Date" \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY}

element create edit_term end_date \
    -label "End Date" \
    -datatype date \
    -widget date \
    -format {MONTH DD YYYY}

element create edit_term referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_request edit_term]} {
    element set_properties edit_term term_name -value $term_name
    element set_properties edit_term term_year -value $term_year
    element set_properties edit_term start_date -value $start_date
    element set_properties edit_term end_date -value $end_date
}

if {[form is_valid edit_term]} {
    form get_values edit_term \
        term_id term_name term_year start_date end_date referer

    dotlrn_term::edit \
        -term_id $term_id \
        -term_name $term_name \
        -term_year [string trim $term_year] \
        -start_date $start_date \
        -end_date $end_date

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
