# dotlrn/www/members.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Jan 19, 2002
    @version $Id$
} -query {
}

set community_id [dotlrn_community::get_community_id]
set user_id [ad_get_user_id]
set context_bar {{"one-community-admin" Admin} {Manage Members}}
set portal_id [dotlrn_community::get_portal_id $community_id $user_id]

ad_return_template
