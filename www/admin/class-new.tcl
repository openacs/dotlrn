ad_page_contract {
    Create a New Class - input form

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-08-20
    @version $Id$
} -query {
    {referer "classes"}
} -properties {
    title:onevalue
    context_bar:onevalue
}

set title "New [ad_parameter classes_pretty_name]"
set context_bar [list [list classes [ad_parameter classes_pretty_plural]] New]

form create add_class

element create add_class class_key \
    -label "[ad_parameter classes_pretty_name] Key (a short name, no spaces)" -datatype text -widget text -html {size 50}

element create add_class name \
    -label "Name" -datatype text -widget text -html {size 50}

element create add_class description \
    -label "Description" -datatype text -widget textarea -html {rows 5 cols 60 wrap soft}

element create add_class referer \
    -label "Referer" -value $referer -datatype text -widget hidden

if {[form is_valid add_class]} {
    form get_values add_class class_key name description referer

    set class_key [dotlrn_class::new -class_key $class_key -pretty_name $name -description $description]

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
