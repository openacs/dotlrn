ad_page_contract {
    Displays a community type

    @author Ben Adida (ben@openforce.net)
    @author yon (yon@openforce.net)
    @creation-date 2001-10-04
} -query {
}

# Check that this is a community type
if {[ad_parameter community_type_level_p] != 1} {
    ad_returnredirect "./"
    ad_script_abort
}

set user_id [ad_conn user_id]

# What community type are we at?
set community_type [dotlrn_community::get_community_type]

# Load some community type info
db_1row select_community_type_info {}

set context_bar {View}

ad_return_template
