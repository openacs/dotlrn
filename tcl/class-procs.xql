<?xml version="1.0"?>

<queryset>
  <fullquery name="dotlrn_class::new.insert_class">
    <querytext>
      insert into dotlrn_classes
      (class_key, department_key)
      values
      (:class_key, :department_key)
    </querytext>
  </fullquery>

  <fullquery name="dotlrn_class::new_instance.select_parent_node_id">
    <querytext>
      select node_id
      from site_nodes
      where object_id = (select package_id
                         from dotlrn_classes_full
                         where class_key = :class_key)
    </querytext>
  </fullquery>

  <fullquery name="dotlrn_class::get_term_id.get_term_id">
    <querytext>
      select term_id
      from dotlrn_class_instances    
      where class_instance_id = :class_instance_id
    </querytext>
  </fullquery>


</queryset>
