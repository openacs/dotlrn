<?xml version="1.0"?>

<queryset>
  <fullquery name="select_dotlrn_users">
    <querytext>
      select first_names,
             last_name,
             email,
             type,
             case when theme_id is null then 1 else 0 end as limited_access_p,
             acs_permission__permission_p(:dotlrn_package_id, user_id, 'read_private_data') as read_private_data_p,
             acs_permission__permission_p(acs__magic_object_id('security_context_root'), user_id, 'admin') as site_wide_admin_p
      from dotlrn_users
      left join dotlrn_full_user_rels on dotlrn_users.rel_id = dotlrn_full_user_rels.rel_id
      order by last_name
    </querytext>
  </fullquery>
</queryset>
