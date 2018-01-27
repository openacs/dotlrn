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

    <fullquery name="dotlrn_class::delete.delete_class">
        <querytext>
            delete from dotlrn_classes
            where class_key = :class_key
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_class::count_class_instances.select_count_class_instaces">
        <querytext>
          select count(*)
          from dotlrn_class_instances
          where class_key = :class_key
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_class::get_term_id.get_term_id">
        <querytext>
            select term_id
            from dotlrn_class_instances    
            where class_instance_id = :class_instance_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_class::can_create.can_create">
        <querytext>
            select count(*)
            from dual
            where exists (select 1
                          from dotlrn_departments)
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_class::check_class_key_valid_p.collision_check">
        <querytext>
            select 1
            from dotlrn_classes
            where dotlrn_classes.class_key = :community_type_key
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_class::can_instantiate.can_instantiate">
        <querytext>
            select count(*)
            from dual
            where exists (select 1
                          from dotlrn_terms
                          where dotlrn_terms.end_date > current_timestamp)
        </querytext>
    </fullquery>
    
</queryset>
