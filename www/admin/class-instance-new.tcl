

ad_page_contract {
    Create a New Class Instance

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-05
} {
    class_key
}

form create add_class_instance

element create add_class_instance pretty_name \
	      -label "Name" -datatype text -widget text -html { size 60 }

element create add_class_instance year \
        -label "Year" -datatype text -widget text -html { size 40 }

element create add_class_instance term \
        -label "Term" -datatype text -widget text -html { size 40 }

element create add_class_instance description \
        -label "Description" -datatype text -widget textarea -html {rows 5 cols 60 wrap soft}

element create add_class_instance class_key \
        -label "Class Key" -value $class_key -datatype text -widget hidden


if {[form is_valid add_class_instance]} {
    template::form get_values add_class_instance class_key pretty_name year term description

    set class_instance_id [dotlrn_class::new_instance -description $description $class_key $pretty_name $term $year]

    ad_returnredirect "one-class?class_key=$class_key"
    return
}

set class_name [dotlrn_community::get_community_type_name $class_key]

set context_bar [list \
	{classes Classes} \
	[list "one-class?class_key=$class_key" "$class_name"] \
	{New Instance}]

ad_return_template

