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
    edit a department

    @author yon (yon@openforce.net)
    @creation-date 2001-03-14
    @version $Id$
} -query {
    department_key:notnull
    {referer "departments"}
} -properties {
    title:onevalue
    context_bar:onevalue
}

if {![db_0or1row select_department_info {}]} {
    ad_return_complaint 1 "<li>Invalid department_key $department_key</li>"
    ad_script_abort
}

set title "Edit [parameter::get -parameter departments_pretty_name] $pretty_name"
set context_bar [list [list departments [parameter::get -parameter departments_pretty_plural]] Edit]

form create edit_department

element create edit_department department_key \
    -label "[parameter::get -parameter departments_pretty_name] Key (a short name, no spaces)" \
    -datatype text \
    -widget hidden \
    -value $department_key

element create edit_department pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create edit_department description \
    -label "Description" \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create edit_department external_url \
    -label "External URL" \
    -datatype text \
    -widget text \
    -html {size 60} \
    -optional

element create edit_department referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_request edit_department]} {
    element set_properties edit_department pretty_name -value $pretty_name
    element set_properties edit_department description -value $description
    element set_properties edit_department external_url -value $external_url
}

if {[form is_valid edit_department]} {
    form get_values edit_department \
        department_key pretty_name description external_url referer

    db_transaction {
        db_dml update_department {}
        db_dml update_community_type {}
    }

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
