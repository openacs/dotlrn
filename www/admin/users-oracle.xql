<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_dotlrn_users">
      <querytext>
        select user_id,
               first_names,
               last_name,
               email,
               type,
               case when dotlrn_full_user_rels.rel_id is null then 't' else 'f' end as limited_access_p,
               acs_permission.permission_p(:dotlrn_package_id, user_id, 'read_private_data') as read_private_data_p,
               acs_permission.permission_p(acs.magic_object_id('security_context_root'), user_id, 'admin') as site_wide_admin_p
        from dotlrn_users, dotlrn_full_user_rels
        where dotlrn_users.rel_id = dotlrn_full_user_rels.rel_id(+)
        order by last_name
      </querytext>
    </fullquery>
</queryset>
