# dotlrn/www/admin/department.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-01-20
    @version $Id$
} -query {
} -properties {
    department_key:onevalue
    pretty_name:onevalue
}

if {![exists_and_not_null pretty_name]} {
    db_1row select_department {}
}

ad_return_template
