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
            ad_complain "You need to confirm the password that you typed. (Type the same thing again.)"
        }
    }
    new_password_match -requires {password_1:notnull password_2:notnull confirm_password} {
        if {![string equal $password_1 $password_2]} {
            ad_complain "Your passwords don't match! Presumably, you made a typo while entering one of them."
        }
    }
}

ad_change_password $user_id $password_1


set system_owner [ad_system_owner]
set system_name [ad_system_name]

set subject "Your password on $system_name"
set body "Please follow the following link to reset your password:

[ad_url]/user/password-update?[export_vars {user_id {password_old $password_1}}]

"

set email [db_string select_user_email {}]

# Send email
if [catch {ns_sendmail $email $system_owner $subject $body} errmsg] {
	ns_log Error "Error sending email to $email from password-update-2.tcl" $errmsg
	ad_return_error \
        "Error sending mail" \
        "There was an error sending email to $email." 
} else {

    set admin_subject "The following email was just sent from [ad_system_name]"
    set admin_message "The following email was just sent from [ad_system_name]

Sent by: $system_owner
Sent to: $email
Subject: $subject
Message: $body"


    if [catch {ns_sendmail $system_owner $system_owner $admin_subject $admin_message} errmsg] {
	
	ns_log Error "Error sending email from password-update-2.tcl" $errmsg
	ad_return_error \
		"Error sending mail" \
		"There was an error sending email to $system_owner."
    }
}


if {[empty_string_p $return_url]} {
    set return_url "user?user_id=$user_id"
}

ad_returnredirect $return_url
