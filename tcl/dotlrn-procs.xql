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

</queryset>
