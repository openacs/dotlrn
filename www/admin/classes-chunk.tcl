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
set departments [linsert $departments 0 {All ""}]

form create department_form

element create department_form department_key \
    -label "Department" \
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

set query "select_classes"
if {![empty_string_p $department_key]} {
    set query "select_classes_by_department"
}

db_multirow classes $query {}

set can_create [dotlrn_class::can_create]

ad_return_template
