# dotlrn/www/communities.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 07, 2001
    @version $Id$
} -query {
    {filter "select_active_communities"}
} -properties {
    n_communities:onevalue
    communities:multirow
}

if {![info exists community_type]} {
    set community_type ""
}

if {![info exists referer]} {
    set referer "./"
}

set user_id [ad_conn user_id]

if {![empty_string_p $community_type]} {
    set n_communities [db_string select_all_communities_count_by_type {}]
} else {
    set n_communities [db_string select_all_communities_count {}]
}

set filter_bar [ad_dimensional {
    {filter "Status:" select_active_communities
        {
            {select_active_communities active {}}
            {select_communities "+inactive" {}}
        }
    }
}]

if {![empty_string_p $community_type]} {
    append filter "_by_type"
}

db_multirow communities $filter {}

ad_return_template
