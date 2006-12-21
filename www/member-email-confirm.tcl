ad_page_contract {
    Confirm an email to be sent
} -query {
    community_id
} -validate {
    community_id_is_dotlrn_community {
	if {[dotlrn_community::get_community_key -community_id $community_id] eq ""} {
	    ad_complain "$community_id is not a valid community_id"
	}
    }
}

permission::require_permission \
    -party_id [ad_conn user_id] \
    -object_id $community_id \
    -privilege admin

set page_title "Confirm Email"
set context [list $page_title]

