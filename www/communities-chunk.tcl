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

# dotlrn/www/communities-chunk.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Dec 07, 2001
    @cvs-id $Id$
} -query {
    {filter "select_all_memberships"}
} -properties {
    communities_p:onevalue
    communities:multirow
}

if {![info exists community_type]} {
    set community_type ""
}

set user_id [ad_conn user_id]

set communities_p [db_string communities_p {
    select exists (
                   select 1 from dotlrn_communities_not_closed
                   where (:community_type is null or community_type = :community_type)
                   ) from dual
}]

set filter_bar [ad_dimensional [list [list filter "[_ dotlrn.Memberships_1]" select_all_memberships \
        {
            {select_all_memberships current {}}
            {select_all_non_memberships join {}}
        }]]]

db_multirow -extend {query url referer} communities $filter {} {
    set referer "./"
    set url [dotlrn_community::get_community_url $community_id]
    set query $filter
}


template::list::create \
    -name communities \
    -multirow communities \
    -elements {
        pretty_name {
	    label "\#dotlrn.clubs_pretty_plural\#"
	    link_url_eval {$url}
	}
	member_p {
	    label "\#dotlrn.Actions\#"
	    display_template {
		<if @communities.member_p;literal@ false>
		   <center>
		   <include src="/packages/dotlrn/www/register-link" url="register?community_id=@communities.community_id@&referer=@communities.referer@">
                   </center>
		</if>
		<else>
		   <center>
		   <include src="/packages/dotlrn/www/deregister-link" url="deregister?community_id=@communities.community_id@&referer=@communities.referer@">
		   </center>
		</else>
	    }
	}
    } 

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
