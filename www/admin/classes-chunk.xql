<?xml version="1.0"?>

<queryset>
    <fullquery name="select_classes">
        <querytext>
            select dotlrn_classes_full.class_key,
                   dotlrn_classes_full.pretty_name,
                   dotlrn_classes_full.description,
                   dotlrn_classes_full.department_key,
                   dotlrn_departments_full.pretty_name as department_name
            from dotlrn_classes_full,
                 dotlrn_departments_full
            where dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
            order by dotlrn_departments_full.pretty_name,
                     dotlrn_classes_full.class_key,
                     dotlrn_classes_full.pretty_name
        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_classes_full.class_key,
                   dotlrn_classes_full.pretty_name,
                   dotlrn_classes_full.description,
                   dotlrn_classes_full.department_key,
                   dotlrn_departments_full.pretty_name as department_name
            from dotlrn_classes_full,
                 dotlrn_departments_full
            where dotlrn_classes_full.department_key = :department_key
            and dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
            order by dotlrn_classes_full.class_key,
                     dotlrn_classes_full.pretty_name
        </querytext>
    </fullquery>
</queryset>
