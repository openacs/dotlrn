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

# dotlrn/www/admin/edit-preapproved-emails.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-03-05
    @version $Id$
} -query {
    {referer "/dotlrn/admin"}
} -properties {
    context_bar:onevalue
}

form create edit_emails

element create edit_emails emails \
    -label "Pre-approved Email Servers" \
    -datatype text \
    -widget text \
    -html {size 50} \
    -value [dotlrn::parameter auto_dotlrn_user_email_patterns]

if {[form is_valid edit_emails]} {
    form get_values edit_emails emails

    dotlrn::parameter -set $emails auto_dotlrn_user_email_patterns

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
