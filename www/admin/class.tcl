# dotlrn/www/admin/class.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 10, 2001
    @version $Id$
} -query {
} -properties {
    class_key:onevalue
    pretty_name:onevalue
    instances:multirow
}

db_multirow instances select_class_instances {}

ad_return_template
