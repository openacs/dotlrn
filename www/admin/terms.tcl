# dotlrn/www/admin/terms.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 13, 2001
    @version $Id$
} -query {
} -properties {
    context_bar:onevalue
    terms:multirow
}

set context_bar "Terms"

db_multirow terms select_terms {}

ad_return_template
