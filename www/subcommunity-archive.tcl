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
    Archive a subcommunity (aka subgroup)

    @author arjun (arjun@openforce.net)
    @version $Id$
} -query {
    {community_id:notnull}
    {referer "one-community-admin"}
} -properties {
    title:onevalue
}

set user_id [ad_get_user_id]
dotlrn::require_user_admin_community $community_id
set pretty_name [dotlrn_community::get_community_name $community_id]
set subcomm_pn [ad_parameter subcommunity_pretty_name]
set title "Archive $subcomm_pn"

form create archive_subcomm

# this is lame, but I don't have a better way yet
set yes_label "Yes, I'm sure."
set no_label "No, I don't want to archive this group."

element create archive_subcomm no_button \
    -label $no_label \
    -datatype text \
    -widget submit \
    -value "1"

element create archive_subcomm yes_button \
    -label $yes_label  \
    -datatype text \
    -widget submit

element create archive_subcomm community_id \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $community_id

element create archive_subcomm referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid archive_subcomm]} {
    form get_values archive_subcomm community_id referer no_button yes_button

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
