# dotlrn/www/community-types-chunk.tcl

ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date Dec 07, 2001
    @version $Id$
} -query {
} -properties {
    community_types:multirow
}

set community_type [dotlrn_community::get_community_type]

db_multirow community_types select_community_types {}

ad_return_template
