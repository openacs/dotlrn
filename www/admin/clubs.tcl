# dotlrn/www/admin/clubs.tcl

ad_page_contract {
    displays dotLRN clubs admin page
    
    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @version $Id$
} -query {
} -properties {
    title:onevalue
    context_bar:onevalue
    clubs:multirow
}

set title "[ad_parameter clubs_pretty_plural]"
set context_bar [list [ad_parameter clubs_pretty_plural]]

db_multirow clubs select_clubs {}

ad_return_template
