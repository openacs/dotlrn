ad_page_contract {
    @author yon (yon@openforce.net)
    @creation-date 2002-01-30
    @version $Id$
} -query {
    {type "admin"}
    {search_text ""}
    {referer "users"}
} -properties {
    user_id:onevalue
    users:multirow
}

set user_id [ad_conn user_id]

form create user_search

element create user_search search_text \
    -label Search \
    -datatype text \
    -widget text \
    -value $search_text

element create user_search type \
    -label Type \
    -datatype text \
    -widget hidden \
    -value $type

element create user_search referer \
    -label Referer \
    -datatype text \
    -widget hidden \
    -value $referer

if {[form is_valid user_search]} {
    form get_values user_search search_text referer

    set user_id [ad_conn user_id]
    set dotlrn_package_id [dotlrn::get_package_id]
    set root_object_id [acs_magic_object security_context_root]

    if {[string equal $type "pending"] == 1} {
        db_multirow users select_non_dotlrn_users {}
    } else {
        db_multirow users select_dotlrn_users {}
    }
} else {
    multirow create users dummy
}

ad_return_template