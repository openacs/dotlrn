ad_page_contract {
    Updates the users password if password_1 matches password_2
   
    @cvs-id $Id$
} {
    user_id:integer,notnull
    password_1:notnull
    password_2:notnull
    {return_url ""}

} -validate {
    confirm_password -requires {password_2:notnull} {
        if {[empty_string_p $password_2]} {
            ad_complain "[_ dotlrn.lt_You_need_to_confirm_t]"
        }
    }
    new_password_match -requires {password_1:notnull password_2:notnull confirm_password} {
        if {![string equal $password_1 $password_2]} {
            ad_complain "[_ dotlrn.lt_Your_passwords_dont_m]"
        }
    }
}

ad_change_password $user_id $password_1


set system_owner [ad_system_owner]
set system_name [ad_system_name]

set subject "[_ dotlrn.lt_Your_password_on_syst]"
set change_password_url "[ad_url]/user/password-update?[export_vars {user_id {password_old $password_1}}]"
set body "[_ dotlrn.lt_Please_follow_the_fol]"

set email [acs_user::get_element -user_id $user_id -element email]

# Send email
if [catch {ns_sendmail $email $system_owner $subject $body} errmsg] {
	ns_log Error "[_ dotlrn.lt_Error_sending_email_t]" $errmsg
	ad_return_error \
        "[_ dotlrn.Error_sending_mail]" \
        "[_ dotlrn.lt_There_was_an_error_se]" 
} else {

    set system_name [ad_system_name]
    set admin_subject "[_ dotlrn.lt_The_following_email_w]"
    set admin_message "[_ dotlrn.lt_The_following_email_w_1]"


    if [catch {ns_sendmail $system_owner $system_owner $admin_subject $admin_message} errmsg] {
	
	ns_log Error "Error sending email from password-update-2.tcl" $errmsg
	ad_return_error \
		"[_ dotlrn.Error_sending_mail]" \
		"[_ dotlrn.lt_There_was_an_error_se_1]"
    }
}


if {[empty_string_p $return_url]} {
    set return_url "user?user_id=$user_id"
}

ad_returnredirect $return_url
