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
    Displays single dotLRN class page

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-07
    @version $Id$
} -query {
    class_key:notnull
    {term_id -1}
} -properties {
    pretty_name:onevalue
    description:onevalue
    class_instances:multirow
    can_instantiate:onevalue
}

# Get information about that class
if {![db_0or1row select_class_info {}]} {
    ad_returnredirect classes
    ad_script_abort
}

set description [ad_quotehtml $description]

set terms [db_list_of_lists select_terms_for_select_widget {}]
set terms [linsert $terms 0 {All -1}]

form create term_form

element create term_form term_id \
    -label [_ dotlrn.Term] \
    -datatype integer \
    -widget select \
    -options $terms \
    -html {onChange document.term_form.submit()} \
    -value $term_id

element create term_form class_key \
    -label "[_ dotlrn.Class_Key]" \
    -datatype text \
    -widget hidden \
    -value $class_key

if {[form is_valid term_form]} {
    form get_values term_form term_id class_key
}

set query select_class_instances
if {$term_id == -1} {
    set query select_all_class_instances
}

db_multirow class_instances $query {}

set can_instantiate [dotlrn_class::can_instantiate]

set context_bar [list [list classes [parameter::get -localize -parameter classes_pretty_plural]] $pretty_name]
set referer "[ns_conn url]?[ns_conn query]"

# Used by some en_US messages on the adp page
set classes_pretty_name [parameter::get -localize -parameter classes_pretty_name]
set class_instances_pretty_name [parameter::get -localize -parameter class_instances_pretty_name]
set class_instances_pretty_plural [parameter::get -localize -parameter class_instances_pretty_plural]

ad_return_template
