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
    @version $Id$
} -query {
    {filter "select_all_non_memberships"}
} -properties {
    n_communities:onevalue
    communities:multirow
}

if {![info exists community_type]} {
    set community_type ""
}

set user_id [ad_conn user_id]

if {![empty_string_p $community_type]} {
    set n_communities [db_string select_all_communities_count_by_type {}]
} else {
    set n_communities [db_string select_all_communities_count {}]
}

set filter_bar [ad_dimensional [list [list filter "[_ dotlrn.Memberships_1]" select_all_non_memberships \
        {
            {select_all_memberships current {}}
            {select_all_non_memberships join {}}
        }]]]

if {![empty_string_p $community_type]} {
    append filter "_by_type"
}

if {![exists_and_not_null referer]} {
    set referer "./"
}

db_multirow communities $filter {}

ad_return_template

