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
# BEN HACK
# set portal_id [dotlrn_community::get_portal_id $community_id $user_id]
set portal_id [dotlrn_community::get_portal_template_id $community_id]
set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id $community_id]

if {[empty_string_p $portal_id] && $admin_p} {
    # the admin using this page is not a member of this comm, but they
    # need he contol panel link (they will probably be confused as to 
    # where they are, so...
    set portal_id [dotlrn_community::get_community_admin_portal_id $community_id]
}

ad_return_template
