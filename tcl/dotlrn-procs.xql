<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn::install.check_group_type_exist">
<querytext>
select count(*) from acs_object_types where object_type=:group_type_key
</querytext>
</fullquery>

<fullquery name="dotlrn::install_classes.check_group_type_exist">
<querytext>
select count(*) from acs_object_types where object_type=:class_group_type_key
</querytext>
</fullquery>

<fullquery name="dotlrn::install_clubs.check_group_type_exist">
<querytext>
select count(*) from acs_object_types where object_type=:club_group_type_key
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

</queryset>
