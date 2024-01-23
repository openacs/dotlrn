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
    @cvs-id $Id$
} -query {
    {referer:localurl "terms"}
} -properties {
    context_bar:onevalue
}

#Pages in this directory are only runnable by dotlrn-wide admins.
dotlrn::require_admin 

ad_form -name add_term -export referer -form {

    {term_name:text          {label "[_ dotlrn.Term_eg_Spring_Fall]"} {maxlength 20}
    {html {size 30}}}

    {start_date:text(h5date)
	{label "[_ dotlrn.Start_Date]"}
    }
    {end_date:text(h5date)
	{label "[_ dotlrn.End_Date]"}
    }

} -validate {
    {start_date
        { [template::util::date::compare $start_date $end_date] <= 0 }
        "The term must start before it ends"
    }
    {end_date
        { [template::util::date::compare [template::util::date::from_ansi [clock format [clock seconds] -format "%Y-%m-%d"]] $end_date] <= 0 }
        "The term must end in the future"
    }
} -on_submit {
    
    # Setting the right format to send to the procedures
    # dotlrn_term::start_end_dates_to_term_year  and
    # dotlrn_term::new
    
    set start_date [split $start_date "-"]
    lappend start_date ""
    lappend start_date ""
    lappend start_date ""
    lappend start_date "MONTH DD YYYY"
    set end_date [split $end_date "-"]
    lappend end_date ""
    lappend end_date ""
    lappend end_date ""
    lappend end_date "MONTH DD YYYY"

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


# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
