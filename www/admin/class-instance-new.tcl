ad_page_contract {
    Create a New Class Instance

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
    @version $Id$
} -query {
    class_key
    {referer ""}
}

form create add_class_instance

element create add_class_instance year \
    -label "Year" -datatype text -widget text -html {size 50}

element create add_class_instance term \
    -label "Term" -datatype text -widget text -html {size 50}

element create add_class_instance description \
    -label "Description" -datatype text -widget textarea -html {rows 5 cols 60 wrap soft}

element create add_class_instance class_key \
    -label "Class Key" -value $class_key -datatype text -widget hidden

element create add_class_instance referer \
    -label "Referer" -value $referer -datatype text -widget hidden

if {[form is_valid add_class_instance]} {
    template::form get_values add_class_instance class_key year term description referer

    set class_instance_id [dotlrn_class::new_instance -description $description -class_type $class_key -term $term -year $year]

    if {[empty_string_p $referer]} {
        set referer "one-class?class_key=$class_key"
    }

    ad_returnredirect $referer
    ad_script_abort
}

set class_name [dotlrn_community::get_community_type_name $class_key]

set context_bar [list \
        {classes Classes} \
        [list "one-class?class_key=$class_key" "$class_name"] \
        {New Instance}]

ad_return_template
