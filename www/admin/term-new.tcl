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
    create a new term - input form

    @author yon (yon@openforce.net)
    @creation-date 2001-12-13
    @version $Id$
} -query {
    {referer "terms"}
} -properties {
    context_bar:onevalue
}

ad_form -name add_term -export referer -form {

    {term_name:text          {label "Term (e.g. Spring, Fall)"} {maxlength 20}
    {html {size 30}}}

    {start_date:date
                             {label "Start Date"}
                             {format {MONTH DD YYYY}}}

    {end_date:date
                             {label "End Date"}
                             {format {MONTH DD YYYY}}}
} -validate {
    {start_date
        { [template::util::date::compare $start_date $end_date] <= 0 }
        "The term must start before it ends"
    }
} -on_submit {

    set term_year [dotlrn_term::start_end_dates_to_term_year \
        -start_date $start_date \
        -end_date $end_date
    ]

#    error [string bytelength $term_name]

    dotlrn_term::new \
        -term_name $term_name \
        -term_year $term_year \
        -start_date $start_date \
        -end_date $end_date

    ad_returnredirect $referer
    ad_script_abort
}

set context_bar [list [list terms [_ dotlrn.Terms]] [_ dotlrn.New]]

ad_return_template

