<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_user_info">
    <querytext>
      select dotlrn_users.id,
             dotlrn_users.first_names,
             dotlrn_users.last_name,
             dotlrn_users.email,
             dotlrn_users.type,
             case when dotlrn_full_user_rels.rel_id is null then 'limited' else 'full' end as access_level,
             acs_permission.permission_p(:dotlrn_package_id, :user_id, 'read_private_data') as read_private_data_p
      from dotlrn_users,
           dotlrn_full_user_rels
      where dotlrn_users.user_id = :user_id
      and dotlrn_users.rel_id = dotlrn_full_user_rels.rel_id(+)
    </querytext>
  </fullquery>

</queryset>
