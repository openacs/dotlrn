
ad_page_contract {
    Choose a role
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-11-04
} {
    user_id
}

form create add_user

element create add_user user_id \
	-label "User ID" -datatype integer -widget hidden -value $user_id

element create add_user type_id \
	-label "User Type" -datatype text -widget select -options [dotlrn::get_user_types]

element create add_user rel_type \
	-label "Access" -datatype text -widget select -options {{{Limited Access} dotlrn_user_rel} {{Full Access} dotlrn_full_user_rel}}

element create add_user read_private_data_p \
        -label "Can Access Private Information?" -datatype text -widget select -options {{Yes t} {No f}}

if {[form is_valid add_user]} {
    template::form get_values add_user user_id type_id rel_type read_private_data_p

    db_transaction {
        # add the user
        dotlrn::user_add -rel_type $rel_type -user_id $user_id -type_id $type_id

        acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] -value $read_private_data_p
    }

    # redirect
    ad_returnredirect "users"
    return
}

db_1row select_user_info "select first_names,last_name from registered_users where user_id= :user_id"

set context_bar {{users Users} New}
ad_return_template

