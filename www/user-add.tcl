# dotlrn/www/user-add.tcl

ad_page_contract {
    Adding a user by an administrator

    @author yon (yon@openforce.net)
    @creation-date Jan 19, 2002
    @cvs-id $Id$
} -query {
    {referer "members"}
    {type "student"}
    {rel_type "dotlrn_full_user_rel"}
    {read_private_data_p "t"}
} -properties {
    context_bar:onevalue
}

set user_id [ad_maybe_redirect_for_registration]

if {![dotlrn::admin_p -user_id $user_id]} {
    ad_returnredirect "not-allowed"
    ad_script_abort
}

set context_bar {{"one-community-admin" Admin} {Add User}}

set target_user_id [db_nextval acs_object_id_seq]

form create add_user

element create add_user target_user_id \
    -label "User ID" -value $target_user_id -datatype integer -widget hidden

element create add_user email \
    -label "Email" -datatype text -widget text -html {size 50} \
    -validate {
        {expr (([util_email_valid_p $value] == 1) && ([util_email_unique_p $value] == 1))}
        {E-mail address must be valid and unique}
    }

element create add_user first_names \
    -label "First Names" -datatype text -widget text -html {size 50}

element create add_user last_name \
    -label "Last Name" -datatype text -widget text -html {size 50}

element create add_user referer \
    -label "Referer" -value $referer -datatype text -widget hidden

element create add_user rel_type \
    -label "Rel Type" -value $rel_type -datatype text -widget hidden

element create add_user type \
    -label "Type" -value $type -datatype text -widget hidden

element create add_user read_private_data_p \
    -label "Can Read Private Data" -value $read_private_data_p -datatype text -widget hidden

if {[form is_valid add_user]} {
    template::form get_values add_user target_user_id email first_names last_name referer rel_type type read_private_data_p

    db_transaction {
        # create the ACS user
        set password [ad_generate_random_string]
        set target_user_id [ad_user_new $email $first_names $last_name $password "" "" "" "t" "approved" $target_user_id]

        # make the user a dotLRN user
        dotlrn::user_add -rel_type $rel_type -user_id $target_user_id -type_id [dotlrn::get_user_type_id_from_type -type $type]

        # can this user read private data?
        acs_privacy::set_user_read_private_data -user_id $target_user_id -object_id [dotlrn::get_package_id] -value $read_private_data_p
    }

    set redirect "user-add-2?[export_vars {{user_id $target_user_id} email password first_names last_name referer}]"
    ad_returnredirect "member-add-2?[export_vars {{user_id $target_user_id} {referer $redirect}}]"
    ad_script_abort
}

ad_return_template
