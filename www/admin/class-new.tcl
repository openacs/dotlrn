ad_page_contract {
    Create a New Class - input form

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-08-20
    @version $Id$
} -query {
    {department_key ""}
    {referer "classes"}
} -properties {
    title:onevalue
    context_bar:onevalue
}

set title "New [ad_parameter classes_pretty_name]"
set context_bar [list [list classes [ad_parameter classes_pretty_plural]] New]

form create add_class

if {[empty_string_p $department_key]} {
    element create add_class department_key \
        -label "[ad_parameter departments_pretty_name]" \
        -datatype text \
        -widget select \
        -options [dotlrn_department::select_as_list]
} else {
    element create add_class department_key \
        -label "[ad_parameter departments_pretty_name]" \
        -datatype text \
        -widget hidden \
        -value $department_key
}

element create add_class pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_class description \
    -label "Description" \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create add_class referer \
    -label "Referer" \
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
