
ad_page_contract {
    Displays single dotLRN class page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-07
} {
    class_key
}

# Get information about that class
if {![db_0or1row select_class_info {}]} {
    ad_returnredirect "classes"
    return
}

# Get all class instances
set list_of_class_instances [dotlrn_community::get_all_communities $class_key]

template::multirow create class_instances class_instance_id pretty_name description

foreach instance $list_of_class_instances {
    template::multirow append class_instances [lindex $instance 0] [lindex $instance 2] [lindex $instance 3]
}

ad_return_template
