# dotlrn/www/admin/clubs.tcl

ad_page_contract {
    displays dotLRN clubs admin page
    
    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} {
} -properties {
    context_bar:onevalue
    clubs:multirow
}

set context_bar "Clubs"

db_multirow clubs select_clubs {}

ad_return_template
