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
    Unarchive a Community

    @author Nima Mazloumi
    @creation-date 2004-04-25
    @version $Id: unarchive.tcl
} -query {
    {community_id ""}
    {referer "."}
}

if { [exists_and_not_null community_id] } {
    set is_archived_p [db_0or1row select_is_archived "select archived_p from dotlrn_communities_all where community_id = :community_id"]
    if { $is_archived_p } {
        ns_log Notice "Unarchiving $community_id"
        dotlrn_community::unarchive -community_id $community_id
    } else {
        ad_return -code error "community must be archived to get unarchived"
    }
} else {
    ad_return -code error "community id expected to unarchive a community"
}
ad_returnredirect $referer
