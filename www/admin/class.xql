<?xml version="1.0"?>

<queryset>

  <fullquery name="select_class_info">
    <querytext>
      select pretty_name,
             description,
             supertype
      from dotlrn_classes_full
      where class_key = :class_key
    </querytext>
  </fullquery>

  <fullquery name="select_all_class_instances">
    <querytext>
      select *
      from dotlrn_class_instances_full dotlrn_class_instances
      where dotlrn_class_instances.class_key = :class_key
    </querytext>
  </fullquery>

  <fullquery name="select_class_instances">
    <querytext>
      select *
      from dotlrn_class_instances_full dotlrn_class_instances
      where dotlrn_class_instances.class_key = :class_key
      and dotlrn_class_instances.term_id = :term_id
    </querytext>
  </fullquery>

</queryset>
