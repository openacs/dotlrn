#
#  Copyright (C) 2001, 2002 MIT
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_page_contract {
    Process the upload

    @author ben (ben@openforce.net)
    @creation-date 2002-03-05
    @version $Id$
}

# get location of the file
set file_location [ns_queryget users_csv_file.tmpfile]

# Prepare stuff
set headers {first_names last_name email}

set admin_user_id [ad_verify_and_get_user_id]
set admin_email [db_string select_admin_email {
    select email
    from parties
    where party_id = :admin_user_id
}]

doc_body_append "[_ dotlrn.Bulk_Uploading]<p>"

set list_of_user_ids [list]
set list_of_addresses_and_passwords [list]

# Do the stuff
# We can't do this too generically, so we'll just do the CSV stuff right here
db_transaction {

    oacs_util::csv_foreach -file $file_location -array_name row {

        # First make sure the required data is there
        if { ![info exists row(email)] || ![info exists row(first_names)] || ![info exists row(last_name)] } {
            doc_body_append "<br>Datafile must include at least the email, first_names and last_name fields<br>"
            db_abort_transaction
            return
        }

        # We need to insert the ACS user
        set password [ad_generate_random_string]

        # Check if this user already exists
        set user_id [cc_lookup_email_user $row(email)]
        if {![empty_string_p $user_id]} {
            doc_body_append [_ dotlrn.user_email_already_exists [list user_email $row(email)]]
            lappend list_of_user_ids $user_id
        } else {

	    set user_id [db_nextval acs_object_id_seq]

	    auth::create_user \
		-user_id $user_id \
		-username "" \
		-email $row(email) \
		-first_names $row(first_names) \
		-last_name $row(last_name) \
		-password $password

            
            lappend list_of_user_ids $user_id
            
            if {![info exists row(type)]} {
                set row(type) student
            }
            
            if {![info exists row(access_level)]} {
                set row(access_level) full
            }
            
            if {![info exists row(guest)]} {
                set row(guest) f
            }

            if {![info exists row(id)]} {
                set row(id) $row(email)
            }
            
            doc_body_append "Creating user $row(email)...."

            # Now we make them a dotLRN user
            switch -exact $row(access_level) {
                limited {
                    dotlrn::user_add -user_id $user_id -id $row(id) -type $row(type)
                }
                full -
                default {
                    dotlrn::user_add -user_id $user_id -id $row(id) -type $row(type) -can_browse
                }
            }
            
            # Set the privacy
            dotlrn_privacy::set_user_guest_p -user_id $user_id -value $row(guest)
            
            doc_body_append [_ dotlrn.user_email_created [list user_email $row(email)]]
            set msg_subst_list [list system_name [ad_system_name] \
                                     system_url [ad_parameter SystemUrl] \
                                     user_email $row(email) \
                                     user_password $password]
            set message [_ dotlrn.user_add_confirm_email_body $msg_subst_list] 
            set subject [_ dotlrn.user_add_confirm_email_subject $msg_subst_list] 

            # Send note to new user
            if [catch {ns_sendmail "$row(email)" "$admin_email" "$subject" "$message"} errmsg] {
                doc_body_append "[_ dotlrn.lt_emailing_this_user_fa]"
                set fail_p 1
            } else {
                doc_body_append "[_ dotlrn.email_sent]"
            }

            lappend list_of_addresses_and_passwords $row(email) $password
        }

        doc_body_append "<br>"
        
    }
} on_error {
    doc_body_append "<p>The database choked while trying to create the last user in the list above!<br>  The transaction has been aborted, no users have been entered, and no e-mail notifications have been sent.<p>"
    ad_script_abort
}

set fail_p 0

doc_body_append "<p>Sending email notifications to users...<p>"

foreach {email password} $list_of_addresses_and_passwords {
    if { ![string equal $password ""] } {
        set message "
You have been added as a user to [ad_system_name] at [ad_parameter -package_id [ad_acs_kernel_id] SystemURL].
            
Login: $email
Password: $password
"
        # Send note to new user
        if [catch {ns_sendmail "$email" "$admin_email" "You have been added as a user to [ad_system_name] at [ad_parameter -package_id [ad_acs_kernel_id] SystemURL]" "$message"} errmsg] {
            doc_body_append "emailing \"$email\" failed!<br>"
            set fail_p 1
        } else {
            doc_body_append "email sent to \"$email\"<br>"
        }
    }
}

if {$fail_p} {
    doc_body_append "<p>[_ dotlrn.lt_Some_of_the_emails_fa]<p>"
}

doc_body_append "<FORM method=post action=users-add-to-community>
<INPUT TYPE=hidden name=users value=\"$list_of_user_ids\">
<INPUT TYPE=hidden name=referer values=users>
[_ dotlrn.lt_You_may_now_choose_to] <INPUT TYPE=submit value=\"[_ dotlrn.lt_Add_These_Users_To_A_]\"></FORM><p>"
doc_body_append "[_ dotlrn.or_return_to] <a href=\"users\">[_ dotlrn.User_Management]</a>."
