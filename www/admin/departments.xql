<?xml version="1.0"?>

<queryset>

    <fullquery name="select_departments">
        <querytext>
            select department_key,
                   pretty_name
            from dotlrn_departments_full
            order by pretty_name,
                     department_key
        </querytext>
    </fullquery>

</queryset>
