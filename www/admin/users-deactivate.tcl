# dotlrn/www/admin/users-deactivate.tcl

ad_page_contract {
    Deactivate a set of users.

    @author yon (yon@openforce.net)
    @creation-date 2002-02-14
    @version $Id$
} -query {
    users
    {referer "users-search"}
} -properties {
    context_bar:onevalue
}

set context_bar {{users Users} {users-search {User Search}} {Deactivate Users}}

form create confirm_deactivate

element create confirm_deactivate users \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $users

if {[form is_valid confirm_deactivate]} {
    form get_values confirm_deactivate \
        users

    foreach user $users {
        acs_user::ban -user_id $user
    }

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
