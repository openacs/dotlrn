ad_page_contract {
    Displays dotLRN classes admin page
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
    {filter "select_current_class_instances"}
} -properties {
    title:onevalue
    context_bar:onevalue
    filter_bar:onevalue
    classes:multirow
}

set title "[ad_parameter classes_pretty_plural]"
set context_bar "[ad_parameter classes_pretty_plural]"

set filter_bar [ad_dimensional {
    {filter "Term:" select_current_class_instances
        {
            {select_current_class_instances current {}}
            {select_current_and_future_class_instances "+future" {}}
            {select_all_class_instances "+past" {}}
        }
    }
}]

db_multirow classes select_classes {}

ad_return_template
