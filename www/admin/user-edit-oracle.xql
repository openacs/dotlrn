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

    <fullquery name="select_user_info">
        <querytext>
            select dotlrn_users.id,
                   dotlrn_users.first_names,
                   dotlrn_users.last_name,
                   dotlrn_users.email,
                   dotlrn_users.type,
                   case when dotlrn_full_user_profile_rels.rel_id is null then 'limited' else 'full' end as access_level,
                   acs_permission.permission_p(:dotlrn_package_id, :user_id, 'read_private_data') as read_private_data_p
            from dotlrn_users,
                 dotlrn_full_user_profile_rels
            where dotlrn_users.user_id = :user_id
            and dotlrn_users.rel_id = dotlrn_full_user_profile_rels.rel_id(+)
        </querytext>
  </fullquery>

</queryset>
