<?xml version="1.0"?>

<queryset>
  <fullquery name="select_terms">
    <querytext>
      select dotlrn_terms.term_id,
             dotlrn_terms.term_name,
             dotlrn_terms.term_year,
             to_char(dotlrn_terms.start_date, 'Mon DD YYYY') as start_date,
             to_char(dotlrn_terms.end_date, 'Mon DD YYYY') as end_date,
             (select count(*)
              from dotlrn_class_instances
              where dotlrn_class_instances.term_id = dotlrn_terms.term_id) as n_classes
      from dotlrn_terms
      order by dotlrn_terms.start_date
    </querytext>
  </fullquery>
</queryset>
