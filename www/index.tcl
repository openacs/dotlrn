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
    Displays the personal home page

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-08-20
    @version $Id$
} -query {
    {filter ""}
    {page_num 0}
}

if {[parameter::get -parameter community_type_level_p] == 1} {
    ad_returnredirect "one-community-type"
    ad_script_abort
} elseif {[parameter::get -parameter community_level_p] == 1} {
    ad_returnredirect "one-community?page_num=$page_num"
    ad_script_abort
}

set user_id [ad_maybe_redirect_for_registration]

if {![dotlrn::user_p -user_id $user_id]} {
    ad_returnredirect "index-not-a-user"
    ad_script_abort
}    

set communities [dotlrn_community::get_all_communities_by_user $user_id]

set access_level [db_string select_users_access_level {
    select access_level
    from dotlrn_users
    where user_id = :user_id
}]

if {[string match $access_level limited] && [llength $communities] == 1} {
    ad_returnredirect [dotlrn_community::get_url_from_package_id \
        -package_id [ns_set get [lindex $communities 0] package_id] \
    ]
    ad_script_abort
}

if {![dotlrn::user_can_browse_p -user_id $user_id]} {

    if {[llength $communities] == 0} {
        ad_returnredirect "index-not-a-user"
        ad_script_abort
    } elseif {[llength $communities] == 1} {
        ad_returnredirect [dotlrn_community::get_url_from_package_id \
            -package_id [ns_set get [lindex $communities 0] package_id] \
        ]
        ad_script_abort
    }

    ad_return_template index-no-browse
    return
}

set portal_id [dotlrn::get_portal_id -user_id $user_id]
set rendered_page [dotlrn::render_page -page_num $page_num -hide_links_p t $portal_id]

ad_return_template
