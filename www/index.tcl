
ad_page_contract {
    Displays a list of Classes on the site
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
} {
} -properties {
    classes:multirow
}

# Temporary Hack to make sure things are installed
dotlrn::install

# Select the classes that exist
db_multirow classes select_classes {}

ad_return_template
