# dotlrn/www/admin/class.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 10, 2001
    @version $Id$
} -query {
    {term_id -1}
} -properties {
    class_key:onevalue
    pretty_name:onevalue
    instances:multirow
    can_instantiate:onevalue
}

set query "select_class_instances"
if {$term_id == -1} {
    set query "select_all_class_instances"
}

db_multirow instances $query {}

set can_instantiate [dotlrn_class::can_instantiate -class_key $class_key]

ad_return_template
