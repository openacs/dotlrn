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
    @author Don Baccus (dhogaza@pacifier.com)

    @creation-date 2002-03-14
    @version $Id$

} -query {
    term_id:integer,notnull
} -properties {
    context_bar:onevalue
}

if {![db_0or1row select_term_info {}]} {
    ad_return_complaint 1 "<li>[_ dotlrn.Invalid] term_key $term_id</li>"
    ad_script_abort
}

set referer "term?[export_vars {term_id}]"
set context_bar [list [list terms [_ dotlrn.Terms]] [list $referer "$term_name $term_year"] [_ dotlrn.Edit]]

ad_form -name edit_term -export term_pretty_name -select_query_name select_term_info -form {

    term_id:key

    {term_name:text               {label "Term (e.g. Spring, Fall)"}
                                  {html {size 30}}}

    {term_year:text               {label "Year (e.g. 2003, 2003/2004)"}
                                  {html {size 9 maxlength 9}}}

    {start_date:date              {label "Start Date"}
                                  {format {MONTH DD YYYY}}}

    {end_date:date                {label "End Date"}
                                  {format {MONTH DD YYYY}}}

} -validate {
    {start_date
        { [template::util::date::compare $start_date $end_date] <= 0 }
        "The term must start before it ends"
    }
} -edit_data {

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

