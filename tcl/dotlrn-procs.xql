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

<fullquery name="dotlrn::get_users_rel_segment_id.select_user_rel_segment">
<querytext>
select segment_id from rel_segments where segment_name='dotLRN Profiled Users'
</querytext>
</fullquery>

<fullquery name="dotlrn::get_full_users_rel_segment_id.select_user_rel_segment">
<querytext>
select segment_id from rel_segments where segment_name='dotLRN Full Profiled Users'
</querytext>
</fullquery>

<fullquery name="dotlrn::get_user_theme.select_user_theme">
<querytext>
select theme_id from dotlrn_full_users where user_id = :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn::set_user_theme.update_user_theme">
<querytext>
update dotlrn_full_user_rels set theme_id= :theme_id where rel_id= (select rel_id from dotlrn_full_users where user_id= :user_id)
</querytext>
</fullquery>

<fullquery name="dotlrn::get_workspace_portal_id.select_user_portal_id">
<querytext>
select portal_id from dotlrn_full_users where user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn::instantiate_and_mount.select_node_id">
<querytext>
select node_id from site_nodes where object_id= :package_id
</querytext>
</fullquery>

  <fullquery name="dotlrn::get_group_id_from_user_type.select_group_id_from_user_type">
    <querytext>
      select dotlrn_user_types.group_id
      from dotlrn_user_types
      where dotlrn_user_types.type = :type
    </querytext>
  </fullquery>

</queryset>
