
ad_page_contract {
    Search for a new user for dotLRN
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    search_text
    community_id
}

# Just search
db_multirow users select_users {}

ad_return_template
