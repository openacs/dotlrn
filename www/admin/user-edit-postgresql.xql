<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="select_user_info">
        <querytext>
            select dotlrn_users.id,
                   dotlrn_users.first_names,
                   dotlrn_users.last_name,
                   dotlrn_users.email,
                   dotlrn_users.type,
                   acs_permission__permission_p(:dotlrn_package_id, :user_id, 'read_private_data') as read_private_data_p
            from dotlrn_users
            where dotlrn_users.user_id = :user_id
        </querytext>
  </fullquery>

</queryset>
