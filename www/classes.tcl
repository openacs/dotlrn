
ad_page_contract {
    Displays the list of classes that can be subscribed to
    
    @author Ben Adida (ben@openforce)
    @creation-date 2001-11-07
} {
} -properties {
    classes:multirow
}

# Get classes
db_multirow classes select_classes {}

ad_return_template
