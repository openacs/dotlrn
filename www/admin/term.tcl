ad_page_contract {
    Displays class instances of a term

    @author yon (yon@openforce.net)
    @creation-date 2002-03-07
    @version $Id$
} -query {
    term_id:integer,notnull
    {department_key ""}
} -properties {
    classes:multirow
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

element create department_form term_id \
    -label "Term ID" \
    -datatype integer \
    -widget hidden \
    -value $term_id

if {[form is_valid department_form]} {
    form get_values department_form department_key term_id
}

set terms [db_list_of_lists select_terms_for_select_widget {
    select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year,
           dotlrn_terms.term_id
    from dotlrn_terms
    where dotlrn_terms.end_date > (sysdate - 360)
    and dotlrn_terms.start_date < (sysdate + 360)
    order by dotlrn_terms.start_date,
             dotlrn_terms.end_date
}]
set terms [linsert $terms 0 {All -1}]

form create term_form

element create term_form term_id \
    -label "Term" \
    -datatype integer \
    -widget select \
    -options $terms \
    -html {onChange document.term_form.submit()} \
    -value $term_id

element create term_form department_key \
    -label "Department" \
    -datatype text \
    -widget hidden \
    -value $department_key

if {[form is_valid term_form]} {
    form get_values term_form term_id department_key

    ad_returnredirect "term?[export_vars {term_id department_key}]"
}

if {![exists_and_not_null referer]} {
    set referer "terms"
}

set query "select_classes"
if {![empty_string_p $department_key]} {
    set query "select_classes_by_department"
}

db_multirow classes $query {}

set title "One Term"
set context_bar {{terms Terms} One}

ad_return_template
