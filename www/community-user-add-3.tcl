
ad_page_contract {
    Add the new user
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    user_id
    rel_type
}

set community_id [dotlrn_community::get_community_id]

# Add the relation
dotlrn_community::add_user -rel_type $rel_type $community_id $user_id

ad_returnredirect "one-class-instance?class_instance_id=$community_id"
