
ad_page_contract {
    register
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-10-06
} {
}

ad_maybe_redirect_for_registration

set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]

dotlrn_community::add_user -rel_type dotlrn_student_rel $community_id $user_id

ns_returnredirect ./
