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
    Create a New Class - input form

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-08-20
    @version $Id$
} -query {
    {department_key ""}
    {referer classes}
} -properties {
    title:onevalue
    context_bar:onevalue
}

set title "New [parameter::get -parameter classes_pretty_name]"
set context_bar [list [list classes [parameter::get -parameter classes_pretty_plural]] New]

form create add_class

element create add_class department_key \
    -label [parameter::get -parameter departments_pretty_name] \
    -datatype text \
    -widget select \
    -options [dotlrn_department::select_as_list] \
    -value $department_key

element create add_class pretty_name \
    -label Name \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_class description \
    -label Description \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create add_class referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_class]} {
    form get_values add_class \
        department_key pretty_name description referer

    set class_key [dotlrn_class::new \
        -department_key $department_key \
        -pretty_name $pretty_name \
        -description $description]

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
