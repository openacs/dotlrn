
ad_page_contract {
    Displays a list of Classes on the site
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
} -properties {
    classes:multirow
}

if {[ad_parameter community_type_level_p] == 1} {
    ns_returnredirect one-community-type
    return
}

# Select the classes that exist
db_multirow classes select_classes {}

ad_return_template
