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

# Do the stuff
# We can't do this too generically, so we'll just do the CSV stuff right here
# (Ben: yeah, we wish for more generic stuff here).
db_transaction {
    oacs_util::csv_foreach -file $file_location -array_name row {
        # We need to insert the ACS user
        set password [ad_generate_random_string]
        set user_id [ad_user_new $row(email) $row(first_names) $row(last_name) $password "" "" "" "t" "approved"]

        # Now we make them a dotLRN user
        dotlrn::user_add -id $row(id) -type $row(type) -access_level $row(access_level) -user_id $user_id

        # Set the privacy
        acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] -value $row(read_private_data_p)

        set message "
You have been added as a user to [ad_system_name] at [ad_parameter SystemUrl].

Login: $row(email)
Password: $password
"

        # Send note to new user
        if [catch {ns_sendmail "$row(email)" "$admin_email" "You have been added as a user to [ad_system_name] at [ad_parameter SystemUrl]" "$message"} errmsg] {
#              ad_return_error "Mail Failed" "The system was unable to send email. Please notify the user personally. This problem is probably caused by a misconfiguration of your email system. Here is the error:
#              <blockquote><pre>
#              [ad_quotehtml $errmsg]
#              </pre></blockquote>"
#              ad_script_abort
        }
        
    }
}

ad_returnredirect "users"
