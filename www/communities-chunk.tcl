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

set filter_bar [ad_dimensional {
    {filter "Memberships:" select_all_non_memberships
        {
            {select_all_memberships current {}}
            {select_all_non_memberships join {}}
        }
    }
}]

if {![empty_string_p $community_type]} {
    append filter "_by_type"
}

if {![exists_and_not_null referer]} {
    set referer "all-communities"
}

db_multirow communities $filter {}

ad_return_template
