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
    Displays dotLRN classes admin page

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
} -properties {
    classes:multirow
}

if {![exists_and_not_null department_key]} {
    set department_key ""
}

set departments [db_list_of_lists select_departments_for_select_widget {
    select dotlrn_departments_full.pretty_name,
           dotlrn_departments_full.department_key
    from dotlrn_departments_full
    order by dotlrn_departments_full.pretty_name,
             dotlrn_departments_full.department_key
}]
set departments [linsert $departments 0 [list [_ dotlrn.All] ""]]

form create department_form

element create department_form department_key \
    -label [_ dotlrn.Department] \
    -datatype text \
    -widget select \
    -options $departments \
    -html {onChange document.department_form.submit()} \
    -value $department_key

if {[form is_valid department_form]} {
    form get_values department_form department_key
}

if {![exists_and_not_null referer]} {
    set referer "classes?[export_vars department_key]"
}

set query select_classes
if {![empty_string_p $department_key]} {
    set query select_classes_by_department
}

db_multirow classes $query {}

set can_create [dotlrn_class::can_create]
set can_instantiate [dotlrn_class::can_instantiate]

# Used in the en_US versions of some of the messages in the adp
set classes_pretty_name [parameter::get -localize -parameter classes_pretty_name]
set classes_pretty_plural [parameter::get -localize -parameter classes_pretty_plural]
set class_instances_pretty_name [parameter::get -localize -parameter class_instances_pretty_name]

ad_return_template
