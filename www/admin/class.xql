<?xml version="1.0"?>

<queryset>
  <fullquery name="select_class_instances">
    <querytext>
      select class_instance_id
      from dotlrn_class_instances
      where class_key = :class_key
      order by class_instance_id
    </querytext>
  </fullquery>
</queryset>
