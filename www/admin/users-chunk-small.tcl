ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
} -properties {
    user_id:onevalue
    users:multirow
}

set user_id [ad_conn user_id]
set dotlrn_package_id [dotlrn::get_package_id]
set root_object_id [acs_magic_object security_context_root]

if {![exists_and_not_null type]} {
    set type admin
}

if {![exists_and_not_null referer]} {
    set referer users
}

# Currently, just present a list of dotLRN users
if {[string equal $type "pending"] == 1} {
    db_multirow users select_non_dotlrn_users {}
} else {
    db_multirow users select_dotlrn_users {}
}

ad_return_template
