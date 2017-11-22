<?xml version="1.0"?>

<queryset>

    <fullquery name="select_class_info">
        <querytext>
            select pretty_name,
                   description
            from dotlrn_classes_full
            where class_key = :class_key
        </querytext>
    </fullquery>

    <fullquery name="update_community_info">
      <querytext>
        update dotlrn_communities_all
        set active_start_date = to_date(:active_start_date, 'YYYY-MM-DD HH24:MI:SS'),
          active_end_date = to_date(:active_end_date, 'YYYY-MM-DD HH24:MI:SS')
        where community_id = :class_instance_id
      </querytext>
    </fullquery>

    <fullquery name="select_terms_for_select_widget">
        <querytext>
            select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year as term,
                   dotlrn_terms.term_id
            from dotlrn_terms
            where dotlrn_terms.end_date > current_timestamp
            order by dotlrn_terms.start_date
        </querytext>
    </fullquery>    

</queryset>
