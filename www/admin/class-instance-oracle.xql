<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_class_instance">
    <querytext>
      select dotlrn_class_instances.pretty_name,
             dotlrn_class_instances.url
      from dotlrn_class_instances_full dotlrn_class_instances
      where dotlrn_class_instances.class_instance_id = :class_instance_id
    </querytext>
  </fullquery>
</queryset>
