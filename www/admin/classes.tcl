
ad_page_contract {
    Displays dotLRN classes admin page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
}

db_multirow classes select_classes {}

set context_bar "Classes"
ad_return_template
