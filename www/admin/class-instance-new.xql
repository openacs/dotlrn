<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_class_info">
        <querytext>
            select pretty_name as class_name,
                   description as class_description
            from dotlrn_classes_full
            where class_key = :class_key
        </querytext>
    </fullquery>

</queryset>
