
ad_page_contract {
    Edit a User
    
    @author Ben Adida (ben@openforce.net)
    @creation-date 2001-12-10
} {
    user_id
}

form create edit_user

element create edit_user user_id \
	-label "User ID" -datatype integer -widget hidden -value $user_id

element create edit_user type_id \
	-label "User Type" -datatype text -widget select -options [dotlrn::get_user_types]

element create edit_user rel_type \
	-label "Access" -datatype text -widget select -options {{{Limited Access} dotlrn_user_rel} {{Full Access} dotlrn_full_user_rel}}

element create edit_user read_private_data_p \
        -label "Can Access Private Information?" -datatype text -widget select -options {{Yes t} {No f}}


# Create a form of hidden vars
form create verif_edit_user

element create verif_edit_user user_id -label "User ID" -datatype integer -widget hidden 
element create verif_edit_user type_id -label "Type ID" -datatype integer -widget hidden
element create verif_edit_user rel_type -label "Relationship Type" -datatype text -widget hidden
element create verif_edit_user read_private_data_p -label "Can Read Private Data?" -datatype text -widget hidden

set context_bar {{users Users} {Edit}}
set dotlrn_package_id [dotlrn::get_package_id]

# We verified everything, now we make the change
if {[form is_valid verif_edit_user]} {
    ns_log Notice "BENLOG - verif_edit_user is VALID!"

    template::form get_values verif_edit_user user_id type_id rel_type read_private_data_p
    
    set rel_id [db_string select_rel_id "select rel_id from dotlrn_users where user_id=:user_id"]

    db_transaction {
        # remove the user
        dotlrn::user_remove $user_id

        # add the user
        dotlrn::user_add -rel_type $rel_type -user_id $user_id -type_id $type_id

        # Update permissions
        acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] -value $read_private_data_p
    }
    
    ad_returnredirect "users"
    return
}


if {[form is_valid edit_user]} {
    ns_log Notice "BENLOG - edit_user is VALID!"
    template::form get_values edit_user user_id type_id rel_type read_private_data_p
    ns_log Notice "BENLOG - immediate read_private_data_p is $read_private_data_p"

    # Do something
    set new_rel_type $rel_type
    db_1row select_limited_user_info "select first_names,last_name,object_type as old_rel_type from dotlrn_users, acs_objects where dotlrn_users.user_id= :user_id and dotlrn_users.rel_id= acs_objects.object_id"

    set old_rel_type [db_string select_rel_type "select 'dotlrn_full_user_rel' from dual where exists (select 1 from dotlrn_full_users where user_id=:user_id)" -default "dotlrn_user_rel"]

    if {$new_rel_type == $old_rel_type} {
        ns_log Notice "BENLOG - new_type is the same!"

        # Simply update things
        
        db_transaction {
            # Update straight user info
            db_dml update_user {}

            # Update permissions
            ns_log Notice "BENLOG - read_private_data set to $read_private_data_p"
            acs_privacy::set_user_read_private_data -user_id $user_id -object_id [dotlrn::get_package_id] -value $read_private_data_p
        }
    } else {
        ns_log Notice "BENLOG - new_type is different!"
        # Warn about the change
        
        element set_properties verif_edit_user user_id -value $user_id
        element set_properties verif_edit_user type_id -value $type_id
        element set_properties verif_edit_user rel_type -value $rel_type
        element set_properties verif_edit_user read_private_data_p -value $read_private_data_p

        ad_return_template "user-edit-verify"
        return
    }
    
    # redirect
    ad_returnredirect "users"
    return
}

db_1row select_user_info {}

# set some values
element set_properties edit_user type_id -value $type_id

if {$limited_access_p == "t"} {
    element set_properties edit_user rel_type -value dotlrn_user_rel
} else {
    element set_properties edit_user rel_type -value dotlrn_full_user_rel
}

element set_properties edit_user read_private_data_p -value $read_private_data_p

ad_return_template

