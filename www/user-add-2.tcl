ad_page_contract {
    Processes a new user created by an admin

    @author yon (yon@openforce.net)
    @creation-date 2002-01-20
    @version $Id$
} -query {
    user_id
    email
    password
    first_names
    last_name
    {referer "/acs-admin/users"}
} -properties {
    context_bar:onevalue
    export_vars:onevalue
    system_name:onevalue
    system_url:onevalue
    first_names:onevalue
    last_name:onevalue
    email:onevalue
    password:onevalue
    administration_name:onevalue
}

set context_bar {{"one-community-admin" Admin} {Add User}}

set admin_user_id [ad_verify_and_get_user_id]
set administration_name [db_string select_admin_name {
    select first_names || ' ' || last_name
    from persons
    where person_id = :admin_user_id
}]

set system_name [ad_system_name]
set export_vars [export_vars -form {email referer}]
set system_url [ad_parameter -package_id [ad_acs_kernel_id] SystemURL ""]

ad_return_template
