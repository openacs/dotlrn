<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn_class::new.insert_class">
<querytext>
insert into dotlrn_classes (class_key) values (:class_group_type_key)
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
	(class_instance_id, class_key)
values
	(:community_id, :short_name)
</querytext>
</fullquery>

</queryset>
