
ad_page_contract {
    Create a New Class - processing

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
    class_key:trim
    class_pretty_name:trim
    description
}

set class_key [dotlrn_class::new -description $description -class_key $class_key -pretty_name $class_pretty_name]

ad_returnredirect "classes"

