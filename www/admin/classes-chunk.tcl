ad_page_contract {
    Displays dotLRN classes admin page
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    {filter "select_current_class_instances"}
} -properties {
    filter_bar:onevalue
    classes:multirow
}

if {![exists_and_not_null department_key]} {
    set department_key ""
}

set filter_bar [ad_dimensional {
    {filter "Term:" select_current_class_instances
        {
            {select_current_class_instances current {}}
            {select_current_and_future_class_instances "+future" {}}
            {select_all_class_instances "+past" {}}
        }
    }
}]

if {![exists_and_not_null referer]} {
    if {[empty_string_p $department_key]} {
        set referer "classes?[export_vars filter]"
    } else {
        set referer "one-department?[export_vars {department_key filter}]"
    }
}

set query "select_classes"
if {![empty_string_p $department_key]} {
    set query "select_classes_by_department"
}

db_multirow classes $query {}

ad_return_template
