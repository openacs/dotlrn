# dotlrn/www/communities.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 07, 2001
    @version $Id$
} -query {
    {filter "select_active_communities"}
    {referer "./"}
} -properties {
    n_communities:onevalue
    communities:multirow
}

set user_id [ad_conn user_id]
set community_type [dotlrn_community::get_community_type]

set n_communities [db_string select_all_communities_count {}]

set filter_bar [ad_dimensional {
    {filter "Status:" select_active_communities
        {
            {select_active_communities active {}}
            {select_communities "+inactive" {}}
        }
    }
}]

db_multirow communities $filter {}

ad_return_template
