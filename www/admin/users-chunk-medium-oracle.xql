<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_dotlrn_users_count">
      <querytext>
        select count(*)
        from dual
        where exists (select 1
                      from dotlrn_users
                      where dotlrn_users.type = :type
                      and upper(substr(dotlrn_users.last_name, 1, 1)) = upper(:dimension))
      </querytext>
    </fullquery>

    <fullquery name="select_non_dotlrn_users_count">
      <querytext>
        select count(*)
        from dual
        where exists (select 1
                      from cc_users
                      where not exists (select 1
                                        from dotlrn_users
                                        where dotlrn_users.user_id = cc_users.user_id)
                      and cc_users.member_state = 'approved'
                      and upper(substr(cc_users.last_name, 1, 1)) = upper(:dimension))
      </querytext>
    </fullquery>

    <fullquery name="select_dotlrn_users">
      <querytext>
        select dotlrn_users.user_id,
               dotlrn_users.first_names,
               dotlrn_users.last_name,
               dotlrn_users.email,
               nvl((select 'full'
                    from dotlrn_full_user_profile_rels
                    where dotlrn_full_user_profile_rels.rel_id = dotlrn_users.rel_id),
                   'limited') as access_level,
               acs_permission.permission_p(:dotlrn_package_id, dotlrn_users.user_id, 'read_private_data') as read_private_data_p,
               acs_permission.permission_p(:root_object_id, dotlrn_users.user_id, 'admin') as site_wide_admin_p
        from dotlrn_users
        where dotlrn_users.type = :type
        and upper(substr(dotlrn_users.last_name, 1, 1)) = upper(:section)
        order by dotlrn_users.last_name
      </querytext>
    </fullquery>

    <fullquery name="select_non_dotlrn_users">
      <querytext>
        select cc_users.user_id,
               cc_users.first_names,
               cc_users.last_name,
               cc_users.email,
               'limited' as access_level,
               'f' as read_private_data_p,
               acs_permission.permission_p(:root_object_id, cc_users.user_id, 'admin') as site_wide_admin_p
        from cc_users
        where not exists (select 1
                          from dotlrn_users
                          where dotlrn_users.user_id = cc_users.person_id)
        and cc_users.member_state = 'approved'
        and upper(substr(cc_users.last_name, 1, 1)) = upper(:section)
        order by cc_users.last_name
      </querytext>
    </fullquery>

</queryset>
