<?xml version="1.0"?>

<queryset>

    <fullquery name="select_departments">
        <querytext>
            select department_key,
                   pretty_name,
                   (select count(*)
                    from dotlrn_classes
                    where department_key = dotlrn_departments_full.department_key) as n_classes
            from dotlrn_departments_full
            order by pretty_name,
                     department_key
        </querytext>
    </fullquery>

</queryset>
