# dotlrn/www/communities.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 07, 2001
    @version $Id$
} -query {
} -properties {
    communities:multirow
}

set user_id [ad_conn user_id]
set community_type [dotlrn_community::get_community_type]

db_multirow communities select_communities {}

ad_return_template
