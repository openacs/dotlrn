<?xml version="1.0"?>

<queryset>

    <fullquery name="select_class_info">
        <querytext>
            select pretty_name as class_name,
                   description as class_description
            from dotlrn_classes_full
            where class_key = :class_key
        </querytext>
    </fullquery>

</queryset>
