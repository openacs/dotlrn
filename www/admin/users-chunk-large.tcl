ad_page_contract {
    Displays main dotLRN admin page

    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} -query {
    {search_text ""}
} -properties {
    user_id:onevalue
    users:multirow
}

if {![exists_and_not_null type]} {
    set type admin
}

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

if {[form is_valid user_search]} {
    form get_values user_search search_text

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
