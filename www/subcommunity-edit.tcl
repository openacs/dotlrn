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
    edit a subcommunity (aka subgroup)

    @author arjun (arjun@openforce.net)
    @version $Id$
} -query {
    {community_id:notnull}
    {referer "one-community-admin"}
} -properties {
    title:onevalue
}

set user_id [ad_get_user_id]
set admin_portal_id \
        [dotlrn_community::get_portal_template_id $community_id]

set title "Edit [ad_parameter subcommunity_pretty_name]"
set old_pn [dotlrn_community::get_community_name $community_id]

dotlrn::require_user_admin_community $community_id

form create edit_subcomm

element create edit_subcomm pretty_name \
    -label "Rename $old_pn to:" \
    -datatype text \
    -widget text \
    -html {size 40} \
    -value $old_pn

element create edit_subcomm referer \
    -label "Referer" \
    -datatype text \
    -widget hidden \
    -value $referer

element create edit_subcomm community_id \
    -label "community_id" \
    -datatype text \
    -widget hidden \
    -value $community_id

if {[form is_valid edit_subcomm]} {
    form get_values edit_subcomm pretty_name referer community_id

    dotlrn_community::set_community_name  \
                -community_id $community_id \
                -pretty_name $pretty_name
    
    ad_returnredirect "$referer"

    ad_script_abort
}

ad_return_template
