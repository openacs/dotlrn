ad_page_contract {
    Displays single dotLRN class page
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-07
    @version $Id$
} -query {
    class_key:notnull
} -properties {
    pretty_name:onevalue
    description:onevalue
    class_instances:multirow
    can_instantiate:onevalue
}

# Get information about that class
if {![db_0or1row select_class_info {}]} {
    ad_returnredirect "classes"
    return
}

db_multirow class_instances select_class_instances {}

set can_instantiate [db_string can_instantiate_class {}]

set context_bar {{classes Classes} One}

ad_return_template
