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
    Archive a group (need to rename file)

    @author arjun (arjun@openforce.net)
    @version $Id$
} -query {
    {community_id ""}
    {referer "one-community-admin"}
} -properties {
    title:onevalue
}

if {[empty_string_p $community_id]} {
    set community_id [dotlrn_community::get_community_id]
}


set user_id [ad_get_user_id]
dotlrn::require_user_admin_community -community_id $community_id
set pretty_name [dotlrn_community::get_community_name $community_id]
set title "Archive group $pretty_name"

form create archive_form

# this is lame, but I don't have a better way yet
set yes_label "Yes, I'm sure."
set no_label "No, I don't want to archive this group."

element create archive_form no_button \
    -label $no_label \
    -datatype text \
    -widget submit \
    -value "1"

element create archive_form yes_button \
    -label $yes_label  \
    -datatype text \
    -widget submit

element create archive_form community_id \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $community_id

element create archive_form referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid archive_form]} {
    form get_values archive_form community_id referer no_button yes_button

    if {[string equal $yes_button $yes_label]} {

        db_transaction {
            set subcomm_id [dotlrn_community::archive \
                    -community_id $community_id
            ]
        }
    }

    ad_returnredirect "$referer"
    ad_script_abort
} 
