# dotlrn/www/community-types.tcl

ad_page_contract {
    @author yon (yon@milliped.com)
    @creation-date Dec 07, 2001
    @cvs-id $Id$
} -query {
} -properties {
    community_types:multirow
}

set community_type [dotlrn_community::get_community_type]

db_multirow community_types select_community_types {}

ad_return_template
