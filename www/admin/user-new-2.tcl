
ad_page_contract {
    Choose a role
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    user_id
}

db_1row select_user_info "select first_names,last_name from registered_users where user_id= :user_id"

ad_return_template

