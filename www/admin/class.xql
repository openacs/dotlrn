<?xml version="1.0"?>

<queryset>
  <fullquery name="select_all_class_instances">
    <querytext>
      select class_instance_id
      from dotlrn_class_instances
      where class_key = :class_key
      order by class_instance_id
    </querytext>
  </fullquery>

  <fullquery name="select_current_class_instances">
    <querytext>
      select class_instance_id
      from dotlrn_class_instances_current
      where class_key = :class_key
      order by class_instance_id
    </querytext>
  </fullquery>

  <fullquery name="select_current_and_future_class_instances">
    <querytext>
      select class_instance_id
      from dotlrn_class_instances_not_old
      where class_key = :class_key
      order by class_instance_id
    </querytext>
  </fullquery>

  <fullquery name="can_instantiate_class">
    <querytext>
      select count(*)
      from dotlrn_terms
      where dotlrn_terms.term_id not in (select dotlrn_class_instances.term_id
                                         from dotlrn_class_instances
                                         where dotlrn_class_instances.class_key = :class_key)
    </querytext>
  </fullquery>
</queryset>
