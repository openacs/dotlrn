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
    Create a New Class Instance

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
    @version $Id$
} -query {
    class_key:notnull
    {referer ""}
}

if {![db_0or1row select_class_info {}]} {
    set class_name ""
    set class_description ""
}

form create add_class_instance

element create add_class_instance term \
    -label [_ dotlrn.Term] \
    -datatype integer \
    -widget select \
    -options [db_list_of_lists select_terms_for_select_widget {}]

element create add_class_instance pretty_name \
    -label [_ dotlrn.Name] \
    -datatype text \
    -widget text \
    -html {size 60} \
    -value $class_name \
    -optional

element create add_class_instance description \
    -label [_ dotlrn.Description] \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -value $class_description \
    -optional

element create add_class_instance join_policy \
    -label "[_ dotlrn.Join_Policy]" \
    -datatype text \
    -widget select \
    -options [list [list [_ dotlrn.Open] open] [list "[_ dotlrn.Needs_Approval]" "needs approval"] [list [_ dotlrn.Closed] closed]]

element create add_class_instance class_key \
    -label "[parameter::get -localize -parameter classes_pretty_name] [_ dotlrn.Key]" \
    -datatype text \
    -widget hidden \
    -value $class_key

element create add_class_instance add_instructor \
    -label "[_ dotlrn.Add_Professor]" \
    -datatype text \
    -widget radio \
    -options [list [list [_ dotlrn.Yes] 1] [list [_ dotlrn.No] 0]] \
    -value 1

element create add_class_instance referer \
    -label [_ dotlrn.Referer] \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_class_instance]} {
    form get_values add_class_instance \
        class_key term pretty_name description join_policy add_instructor referer

    set class_instance_id [dotlrn_class::new_instance \
        -class_key $class_key \
        -term_id $term \
        -pretty_name $pretty_name \
        -description $description \
        -join_policy $join_policy \
    ]

    if {[empty_string_p $referer]} {
        set referer "class?class_key=$class_key"
    }

    if {${add_instructor}} {
        ad_returnredirect "add-instructor?community_id=$class_instance_id&referer=$referer"
        ad_script_abort
    }

    ad_returnredirect $referer
    ad_script_abort
}

# Used by en_US version of new_class_instance message
set class_instances_pretty_name [parameter::get -localize -parameter class_instances_pretty_name]

set context_bar [list \
                     [list classes [parameter::get -localize -parameter classes_pretty_plural]] \
                     [list "class?class_key=$class_key" $class_name] \
                     [_ dotlrn.new_class_instance]]

