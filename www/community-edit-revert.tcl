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

    Revert the properties for a community

    @author <a href="mailto:arjun@openforce.net">arjun@openforce.net</a>
    @version $Id$

} -query {
    {referer "community-edit"}
    {header_logo_only ""}
}

set user_id [ad_conn user_id]
set community_id [dotlrn_community::get_community_id]
dotlrn::require_user_admin_community -user_id $user_id -community_id $community_id

if {![empty_string_p $header_logo_only]} {
    # just blow away the header logo stuff
    dotlrn_community::unset_attribute \
        -community_id $community_id \
        -attribute_name header_logo_item_id
    
    dotlrn_community::unset_attribute \
        -community_id $community_id \
        -attribute_name header_logo_alt_text
} else {
    # blow way all the attributes
    dotlrn_community::unset_attributes \
        -community_id $community_id
    
}

ad_returnredirect $referer

