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

doc_body_append "Bulk Uploading....<p>"

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
            doc_body_append "User $row(email) already exists... storing user_id"
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
            
            doc_body_append "User $row(email) created...."
            set message "
            You have been added as a user to [ad_system_name] at [ad_parameter SystemUrl].
            
            Login: $row(email)
            Password: $password
            "
            
            # Send note to new user
            if [catch {ns_sendmail "$row(email)" "$admin_email" "You have been added as a user to [ad_system_name] at [ad_parameter SystemUrl]" "$message"} errmsg] {
                doc_body_append "emailing this user failed!"
                set fail_p 1
            } else {
                doc_body_append "email sent"
            }
        }

        doc_body_append "<br>"
        
    }
}

if {$fail_p} {
    doc_body_append "<p>Some of the emails failed. Those users had random passwords generated for them, however. The best way to proceed is to have these users log in and ask them to click on 'I have forgotten my password'.<p>"
}

doc_body_append "<FORM method=post action=users-add-to-community>
<INPUT TYPE=hidden name=users value=\"$list_of_user_ids\">
<INPUT TYPE=hidden name=referer values=users>
You may now choose to <INPUT TYPE=submit value=\"Add These Users To A Group\"></FORM><p>"
doc_body_append "or, return to <a href=\"users\">User Management</a>."
