ad_page_contract {
    create a new department

    @author yon (yon@openforce.net)
    @creation-date 2001-01-20
    @version $Id$
} -query {
    {referer "departments"}
} -properties {
    title:onevalue
    context_bar:onevalue
}

set title "New [ad_parameter departments_pretty_name]"
set context_bar [list [list departments [ad_parameter departments_pretty_plural]] New]

form create add_department

element create add_department pretty_name \
    -label "Name" \
    -datatype text \
    -widget text \
    -html {size 60}

element create add_department description \
    -label "Description" \
    -datatype text \
    -widget textarea \
    -html {rows 5 cols 60 wrap soft} \
    -optional

element create add_department external_url \
    -label "External URL" \
    -datatype text \
    -widget text \
    -html {size 60} \
    -optional

element create add_department referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid add_department]} {
    form get_values add_department \
         pretty_name description external_url referer

    set department_key [dotlrn_department::new \
        -pretty_name $pretty_name \
        -description $description \
        -external_url $external_url]

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
