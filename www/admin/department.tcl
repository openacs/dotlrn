ad_page_contract {
    Displays single dotLRN class page

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-07
    @version $Id$
} -query {
    {department_key ""}
} -properties {
    pretty_name:onevalue
    external_url:onevalue
    description:onevalue
    classes:multirow
}

if {[empty_string_p $department_key]} {
    ad_returnredirect "/dotlrn/admin/classes"
    ad_script_abort
}

# Get information about that class
if {![db_0or1row select_departments_info {}]} {
    ad_returnredirect "departments"
    ad_script_abort
}

set context_bar [list [list departments [ad_parameter departments_pretty_plural]] $pretty_name]
set referer "[ns_conn url]?[ns_conn query]"

ad_return_template
