

ad_page_contract {
    Displays main dotLRN admin page
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
}

# Currently, just present a list of dotLRN users
db_multirow users select_dotlrn_users {}

ad_return_template
