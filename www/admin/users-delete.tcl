# dotlrn/www/admin/users-delete.tcl

ad_page_contract {
    Delete a set of users.

    @author yon (yon@openforce.net)
    @creation-date 2002-02-14
    @version $Id$
} -query {
    users
    {referer "users-search"}
} -properties {
    context_bar:onevalue
}

set context_bar {{users Users} {users-search {User Search}} {Delete Users}}

form create confirm_delete

element create confirm_delete users \
    -label "&nbsp;" \
    -datatype text \
    -widget hidden \
    -value $users

if {[form is_valid confirm_delete]} {
    form get_values confirm_delete \
        users

    dotlrn::remove_users_completely -users $users

    ad_returnredirect $referer
    ad_script_abort
}

ad_return_template
