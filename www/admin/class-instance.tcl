# dotlrn/www/admin/class-instance.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 10, 2001
    @version $Id$
} -query {
} -properties {
    pretty_name:onevalue
    url:onevalue
}

db_1row select_class_instance {}

ad_return_template
