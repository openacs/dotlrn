<?xml version="1.0"?>

<queryset>
  <fullquery name="select_terms">
    <querytext>
      select term_id,
             term_name,
             term_year,
             to_char(start_date, 'Mon DD YYYY') as start_date,
             to_char(end_date, 'Mon DD YYYY') as end_date
      from dotlrn_terms
      order by start_date
    </querytext>
  </fullquery>
</queryset>
