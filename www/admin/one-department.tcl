ad_page_contract {
    Displays single dotLRN class page
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-07
    @version $Id$
} -query {
    department_key:notnull
} -properties {
    pretty_name:onevalue
    external_url:onevalue
    description:onevalue
    classes:multirow
}

# Get information about that class
if {![db_0or1row select_departments_info {}]} {
    ad_returnredirect "departments"
    ad_script_abort
}

db_multirow classes select_classes {}

set context_bar [list [list departments [ad_parameter departments_pretty_plural]] One]

ad_return_template
