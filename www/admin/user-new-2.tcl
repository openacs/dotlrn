
ad_page_contract {
    Add an actual user
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    user_id
}

# Add the user
dotlrn::user_add $user_id

ad_returnredirect "./"

