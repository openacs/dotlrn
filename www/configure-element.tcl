#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
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
    Displays an element configuration page

    @author Ben Adida (ben@openforce.net)
    @author Arjun Sanyal (arjun@openforce.net)
    @creation-date 2001-10-24
} -query {
    element_id:naturalnum,notnull
    op:notnull
}

if {[parameter::get -parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    ad_script_abort
}

set user_id [ad_maybe_redirect_for_registration]

if {[parameter::get -parameter community_level_p] == 1} {

    set community_id [dotlrn_community::get_community_id]
    set admin_p [dotlrn::user_can_admin_community_p -user_id $user_id -community_id $community_id]

    if {[dotlrn_community::member_p $community_id $user_id] || $admin_p} {
	portal::configure_element $element_id $op "one-community"
    } else {
        ad_returnredirect "one-community"
    }
} else {
    set portal_id [dotlrn::get_portal_id -user_id $user_id]
    if {[empty_string_p $portal_id]} {
	# do something
	ad_returnredirect "/."
    } else {
	set rendered_page [portal::configure_element $element_id $op "index"]
    }
}

ad_return_template
