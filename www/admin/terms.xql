<?xml version="1.0"?>

<queryset>
  <fullquery name="select_terms">
    <querytext>
      select term_id,
             term_name,
             term_year,
             start_date,
             end_date
      from dotlrn_terms
      order by start_date
    </querytext>
  </fullquery>
</queryset>
