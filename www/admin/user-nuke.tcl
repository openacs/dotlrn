ad_page_contract {

    Try to delete a pending user from the database.
    
    @author Andrew Grumet (aegrumet@alum.mit.edu)
    @creation-date 2002-08-08
    @version $Id$
} {
    user_id:integer,notnull
    {referer "[dotlrn::get_admin_url]/users"}
}

db_1row select_user_info {
    select email,
           first_names,
           last_name
    from cc_users
    where user_id = :user_id
}

form create confirm_delete

element create confirm_delete user_id \
    -label "User ID" \
    -datatype integer \
    -widget hidden \
    -value $user_id

element create confirm_delete confirmed_p \
    -label "Are you sure?" \
    -datatype text \
    -widget radio \
    -options {{No f} {Yes t}} \
    -value f

set context_bar {{users Users} Nuke}

if [form is_valid confirm_delete] {
    form get_values confirm_delete user_id confirmed_p
    if [string equal $confirmed_p t] {
	if [catch { db_exec_plsql nuke_user { begin acs.remove_user(:user_id); end; } } errMsg ] {
	    ad_return_template user-nuke-error
	} else {
	    # Nuke was successful.
	    ad_returnredirect $referer
	    ad_script_abort
	}
    } else {
	# Nuke cancelled
	ad_returnredirect $referer
	ad_script_abort
    }
}


