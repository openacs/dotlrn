<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

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
        and (
            lower(dotlrn_users.last_name) like lower('%' || :search_text || '%')
         or lower(dotlrn_users.first_names) like lower('%' || :search_text || '%')
         or lower(dotlrn_users.email) like lower('%' || :search_text || '%')
        )
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
                          where dotlrn_users.user_id = cc_users.user_id)
        and cc_users.member_state = 'approved'
        and (
            lower(cc_users.last_name) like lower('%' || :search_text || '%')
         or lower(cc_users.first_names) like lower('%' || :search_text || '%')
         or lower(cc_users.email) like lower('%' || :search_text || '%')
        )
        order by cc_users.last_name
      </querytext>
    </fullquery>

    <fullquery name="select_deactivated_users">
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
                          where dotlrn_users.user_id = cc_users.user_id)
        and cc_users.member_state = 'banned'
        and (
            lower(cc_users.last_name) like lower('%' || :search_text || '%')
         or lower(cc_users.first_names) like lower('%' || :search_text || '%')
         or lower(cc_users.email) like lower('%' || :search_text || '%')
        )
        order by cc_users.last_name
      </querytext>
    </fullquery>

</queryset>
