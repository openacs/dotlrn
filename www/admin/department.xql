<?xml version="1.0"?>

<queryset>
  <fullquery name="select_department">
    <querytext>
      select department_key,
             pretty_name
      from dotlrn_departments_full
      where department_key = :department_key
    </querytext>
  </fullquery>
</queryset>
