<?xml version="1.0"?>

<queryset>
    <fullquery name="select_classes">
        <querytext>
            select dotlrn_class_instances_full.*
            from dotlrn_class_instances_full
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :department_key
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>
</queryset>
