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

# Do the stuff
# We can't do this too generically, so we'll just do the CSV stuff right here
db_transaction {
    set fail_p 0

    oacs_util::csv_foreach -file $file_location -array_name row {
        # We need to insert the ACS user
        set password [ad_generate_random_string]

        # Check if this user already exists
        set user_id [cc_lookup_email_user $row(email)]
        if {![empty_string_p $user_id]} {
            doc_body_append [_ [ad_conn locale] dotlrn.user_email_already_exists "" [list user_email $row(email)]]
            lappend list_of_user_ids $user_id            
        } else {
            set user_id [ad_user_new $row(email) $row(first_names) $row(last_name) $password "" "" "" "t" "approved"]
            
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
            
            if {$row(guest) == "f"} {
                set inverse_row_guest "t"
            } else {
                set inverse_row_guest "f"
            }
            
            # Set the privacy
            acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] -value $inverse_row_guest
            
            doc_body_append [_ [ad_conn locale] dotlrn.user_email_created "" [list user_email $row(email)]]
            set msg_subst_list [list system_name [ad_system_name] \
                                     system_url [ad_parameter SystemUrl] \
                                     user_email $row(email) \
                                     user_password $password]
            set message [_  [ad_conn locale] dotlrn.user_add_confirm_email_body "" $msg_subst_list] 
            set subject [_  [ad_conn locale] dotlrn.user_add_confirm_email_subject "" $msg_subst_list] 

            # Send note to new user
            if [catch {ns_sendmail "$row(email)" "$admin_email" "$subject" "$message"} errmsg] {
                doc_body_append "[_ dotlrn.lt_emailing_this_user_fa]"
                set fail_p 1
            } else {
                doc_body_append "[_ dotlrn.email_sent]"
            }
        }

        doc_body_append "<br>"
        
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

