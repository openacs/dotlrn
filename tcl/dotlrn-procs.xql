<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn::get_users_rel_segment_id.select_user_rel_segment">
<querytext>
select segment_id from rel_segments where segment_name='dotLRN Users'
</querytext>
</fullquery>

<fullquery name="dotlrn::get_full_users_rel_segment_id.select_user_rel_segment">
<querytext>
select segment_id from rel_segments where segment_name='dotLRN Full Access Users'
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

  <fullquery name="dotlrn::get_user_type_id_from_type.select_user_type_id_from_type">
    <querytext>
      select type_id
      from dotlrn_user_types
      where type = :type
    </querytext>
  </fullquery>

</queryset>
