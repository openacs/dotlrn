# dotlrn/www/admin/term.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} {
} -properties {
    term_id:onevalue
    term_name:onevalue
    term_year:onevalue
    start_date:onevalue
    end_date:onevalue
}

if {![exists_and_not_null term_name]} {
    db_1row select_term {}
}

ad_return_template
