# dotlrn/www/admin/class.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 10, 2001
    @version $Id$
} -query {
    {filter "select_current_class_instances"}
} -properties {
    class_key:onevalue
    pretty_name:onevalue
    instances:multirow
    can_instantiate:onevalue
}

db_multirow instances $filter {}

set can_instantiate [db_string can_instantiate_class {}]

ad_return_template
