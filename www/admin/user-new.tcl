ad_page_contract {
    Search for a new user for dotLRN
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    search_text
}

# Just search
db_multirow users select_users {}

set context_bar {{users Users} {New}}

ad_return_template
