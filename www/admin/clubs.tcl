ad_page_contract {
    displays dotLRN clubs admin page
    
    @author yon (yon@openforce.net)
    @creation-date 2001-12-03
    @cvs-id $Id$
} {
} -properties {
    clubs:multirow
    context_bar:onevalue
}

set context_bar "clubs"

db_multirow clubs select_clubs {}

ad_return_template
