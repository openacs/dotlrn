ad_page_contract {
    Displays dotLRN classes admin page
    
    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-11-04
    @version $Id$
} -query {
} -properties {
    classes:multirow
}

set context_bar "Classes"

db_multirow classes select_classes {}

ad_return_template
