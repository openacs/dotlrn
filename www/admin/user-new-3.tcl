
ad_page_contract {
    Add an actual user
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    user_id
    {role user}
}

# Add the user
dotlrn::user_add -role $role $user_id

ad_returnredirect "users"

