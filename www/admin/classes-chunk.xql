<?xml version="1.0"?>

<queryset>

    <fullquery name="select_classes">
        <querytext>
            select dotlrn_classes_full.class_key,
                   dotlrn_classes_full.pretty_name,
                   dotlrn_classes_full.description,
                   dotlrn_classes_full.department_key,
                   dotlrn_departments_full.pretty_name as department_name,
                   (select count(*)
                     from dotlrn_class_instances, dotlrn_communities_all
                    where dotlrn_class_instances.class_key = dotlrn_classes_full.class_key
                      and dotlrn_class_instances.class_instance_id = dotlrn_communities_all.community_id
                      and dotlrn_communities_all.archived_p = 'f') as n_instances
            from dotlrn_classes_full,
                 dotlrn_departments_full
            where dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
            order by lower(dotlrn_departments_full.pretty_name),
                     lower(dotlrn_classes_full.pretty_name),
                     dotlrn_classes_full.class_key

        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_classes_full.class_key,
                   dotlrn_classes_full.pretty_name,
                   dotlrn_classes_full.description,
                   dotlrn_classes_full.department_key,
                   dotlrn_departments_full.pretty_name as department_name,
                   (select count(*)
                    from dotlrn_class_instances, dotlrn_communities_all
                    where dotlrn_class_instances.class_key = dotlrn_classes_full.class_key
                      and dotlrn_class_instances.class_instance_id = dotlrn_communities_all.community_id
                      and dotlrn_communities_all.archived_p = 'f') as n_instances
            from dotlrn_classes_full,
                 dotlrn_departments_full
            where dotlrn_classes_full.department_key = :department_key
            and dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
            order by lower(dotlrn_classes_full.pretty_name), dotlrn_classes_full.class_key
                     
        </querytext>
    </fullquery>

</queryset>
