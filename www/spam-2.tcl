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

# dotlrn/www/spam-2.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-05-13
    @version $Id$
} -query {
} -properties {
    subject:onevalue
    message:onevalue
    format:onevalue
    spam_name:onevalue
    context_bar:onevalue
    community_id:onevalue
    portal_id:onevalue
}

form get_values spam_message subject message

set content [string trimright [template::util::richtext::get_property contents $message]]
set format [string trimright [template::util::richtext::get_property format $message]]

# the following is just to make sure the previewing works ok.
# in case the user types a html message and chooses the messsage 
# to be a plain text type or vice-versa.
if {$format == "text/html"} {
	if [ad_looks_like_html_p $content] {
	     set preview_message "<pre>$content</pre>"
           } else {
	     set preview_message "$content"
        }
} else {
	set preview_message [ad_quotehtml $content]
}

set context_bar [list [list $referer Admin] "[_ dotlrn.Spam_Community]"]
set community_id [dotlrn_community::get_community_id]
set portal_id [dotlrn_community::get_portal_id -community_id $community_id]
