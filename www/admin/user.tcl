ad_page_contract {
    One user view by a dotLRN admin
    
    @author yon (yon@openforce.net)
    @creation-date 2002-03-13
    @version $Id$
} {
    user_id:integer,notnull
} -properties {
    context_bar:onevalue
    first_names:onevalue
    last_name:onevalue
    email:onevalue
    screen_name:onevalue
    user_id:onevalue
    registration_date:onevalue
    last_visit:onevalue
    export_edit_vars:onevalue
    portrait_p:onevalue
    portrait_title:onevalue
    change_state_links:onevalue
    return_url:onevalue
    dotlrn_user_p:onevalue
    member_classes:multirow
    member_clubs:multirow
}

set return_url "[ad_parameter -package_id [ad_acs_kernel_id] CommunityMemberAdminURL]?user_id=$user_id"
set export_edit_vars [export_url_vars user_id return_url]

if {![db_0or1row select_user_info {}]} {
    ad_return_complaint 1 "<li>We couldn't find user #$user_id; perhaps this person was deleted?</li>"
    ad_script_abort
}
if {[empty_string_p $screen_name]} {
    set screen_name "&lt;none set up&gt;"
}
set registration_date [util_AnsiDatetoPrettyDate $registration_date] 
if {![empty_string_p $last_visit]} {
    set last_visit [util_AnsiDatetoPrettyDate $last_visit]
}

set dotlrn_package_id [dotlrn::get_package_id]
set dotlrn_user_p 0
if {[db_0or1row select_dotlrn_user_info {}]} {
    set dotlrn_user_p 1
}

set portrait_p 0
if {[db_0or1row select_portrait_info {}]} {
    set portrait_p 1
}

set change_state_links "\[<small>[join [ad_registration_finite_state_machine_admin_links $member_state $email_verified_p $user_id $return_url] " | "]</small>\]"

db_multirow member_classes select_member_classes {}
db_multirow member_clubs select_member_clubs {}
db_multirow member_subgroups select_member_subgroups {}

set context_bar [list [list users Users] "$first_names $last_name"]

ad_return_template
