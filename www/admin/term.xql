<?xml version="1.0"?>

<queryset>
  <fullquery name="select_term">
    <querytext>
      select dotlrn_terms.term_name,
             dotlrn_terms.term_year,
             dotlrn_terms.start_date,
             dotlrn_terms.end_date
      from dotlrn_terms
      where dotlrn_terms.term_id = :term_id
    </querytext>
  </fullquery>
</queryset>
