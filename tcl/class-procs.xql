<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn_class::new.insert_class">
<querytext>
insert into dotlrn_classes (class_key, node_id) values (:one_class_group_type_key, :node_id)
</querytext>
</fullquery>

<fullquery name="dotlrn_class::new_instance.select_parent_node_id">
<querytext>
select node_id from dotlrn_classes where class_key=:class_name
</querytext>
</fullquery>

<fullquery name="dotlrn_class::new_instance.insert_class_instance">
<querytext>
insert into dotlrn_class_instances 
	(class_instance_id, class_instance_key, class_key, node_id)
values
	(:group_id, :class_inst_key, :class_name, :node_id)
</querytext>
</fullquery>

<fullquery name="dotlrn_class::assign_role.select_group_id">
<querytext>
select class_instance_id from dotlrn_class_instances where class_instance_key= :class_instance_name
</querytext>
</fullquery>

</queryset>
