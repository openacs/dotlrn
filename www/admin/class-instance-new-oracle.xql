<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_terms_for_select_widget">
    <querytext>
      select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year as term,
             dotlrn_terms.term_id
      from dotlrn_terms
      where dotlrn_terms.end_date > sysdate
      and not exists (select 1
                      from dotlrn_class_instances
                      where dotlrn_class_instances.class_key = :class_key
                      and dotlrn_class_instances.term_id = dotlrn_terms.term_id)
      order by dotlrn_terms.start_date
    </querytext>
  </fullquery>
</queryset>
