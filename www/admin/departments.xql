<?xml version="1.0"?>

<queryset>

    <fullquery name="select_departments">
        <querytext>
            select department_key,
                   pretty_name as department_name,
                   (select count(*)
                    from dotlrn_classes
                    where department_key = dotlrn_departments_full.department_key) as n_classes
            from dotlrn_departments_full
	     where 1 = 1
	    [template::list::page_where_clause -and -name "departments" -key "dotlrn_departments_full.department_key"]
	    [template::list::orderby_clause -orderby -name "departments"]
        </querytext>
    </fullquery>

    <fullquery name="departments_pagination">
        <querytext>
            select department_key,
                   pretty_name as department_name,
                   (select count(*)
                    from dotlrn_classes
                    where department_key = dotlrn_departments_full.department_key) as n_classes
            from dotlrn_departments_full
            [template::list::orderby_clause -orderby -name "departments"]

        </querytext>
    </fullquery>

</queryset>
