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
select theme_id from dotlrn_users where user_id = :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn::set_user_theme.update_user_theme">
<querytext>
update dotlrn_users set theme_id= :theme_id where user_id= :user_id
</querytext>
</fullquery>

</queryset>
