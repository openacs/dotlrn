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
    Sends email confirmation to user after they've been created

    @author yon (yon@openforce.net)
    @creation-date 2002-01-20
    @version $Id$
} -query {
    email
    message
    {referer "/acs-admin/users"}
}

set admin_user_id [ad_verify_and_get_user_id]
set admin_email [db_string select_admin_email {
    select email
    from parties
    where party_id = :admin_user_id
}]

if [catch {ns_sendmail "$email" "$admin_email" "You have been added as a user to [ad_system_name] at [ad_parameter SystemUrl]" "$message"} errmsg] {
    ad_return_error "Mail Failed" "The system was unable to send email. Please notify the user personally. This problem is probably caused by a misconfiguration of your email system. Here is the error:
<blockquote><pre>
[ad_quotehtml $errmsg]
</pre></blockquote>"
    ad_script_abort
}

ad_returnredirect $referer
