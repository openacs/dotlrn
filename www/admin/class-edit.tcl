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
    edit a class

    @author yon (yon@openforce.net)
    @creation-date 2001-03-14
    @version $Id$
} -query {
    class_key:notnull
    {referer classes}
} -properties {
    title:onevalue
    context_bar:onevalue
}

if {![db_0or1row select_class_info {}]} {
    ad_return_complaint 1 "<li>Invalid class_key $class_key</li>"
    ad_script_abort
}

set title "Edit [ad_parameter classes_pretty_name] $pretty_name"
set context_bar [list [list classes [ad_parameter classes_pretty_plural]] Edit]

form create edit_class

element create edit_class class_key \
    -label "Class Key (a short name, no spaces)" \
    -datatype text \
    -widget hidden \
    -value $class_key

element create edit_class pretty_name \
    -label Name \
    -datatype text \
    -widget text \
    -html {size 60}

element create edit_class description \
    -label Description \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create edit_class referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_request edit_class]} {
    element set_properties edit_class pretty_name -value $pretty_name
    element set_properties edit_class description -value $description
}

if {[form is_valid edit_class]} {
    form get_values edit_class \
        class_key pretty_name description referer

    db_dml update_community_type {}

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
