
ad_page_contract {
    Displays a list of Classes on the site
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
} -properties {
    classes:multirow
}

# Select the classes that exist
db_multirow communities select_communities {}

ad_return_template
