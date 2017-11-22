<?xml version="1.0"?>

<queryset>

    <fullquery name="select_class_info">
        <querytext>
            select pretty_name,
                   description,
                   supertype
            from dotlrn_classes_full
            where class_key = :class_key
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_instances">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where 1=1
            $keyword_clause
	    [template::list::page_where_clause -and -name "class_instances" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "class_instances"]
       </querytext>
    </fullquery>

    <fullquery name="select_all_classes_instances_paginator">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where 1=1
            $keyword_clause
            [template::list::orderby_clause -orderby -name "class_instances"]
        </querytext>
    </fullquery>

    <fullquery name="select_all_class_instances">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.class_key = :class_key 
            $keyword_clause
	    [template::list::page_where_clause -and -name "class_instances" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "class_instances"]
       </querytext>
    </fullquery>

    <fullquery name="select_all_class_instances_paginator">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.class_key = :class_key
            $keyword_clause
            [template::list::orderby_clause -orderby -name "class_instances"]
        </querytext>
    </fullquery>

    <fullquery name="select_class_instances">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.class_key = :class_key
            $keyword_clause
            and dotlrn_class_instances_full.term_id = :term_id
	    [template::list::page_where_clause -and -name "class_instances" -key "dotlrn_class_instances_full.class_instance_id"]
	    [template::list::orderby_clause -orderby -name "class_instances"]
        </querytext>
    </fullquery>

    <fullquery name="select_class_instances_paginator">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.class_key = :class_key
            $keyword_clause
            and dotlrn_class_instances_full.term_id = :term_id
            [template::list::orderby_clause -orderby -name "class_instances"]
        </querytext>
    </fullquery>

    <partialquery name="class_instances_keyword">
      <querytext>
	and dotlrn_class_instances_full.pretty_name like '%'||:keyword||'%'
      </querytext>
    </partialquery>

    <fullquery name="select_terms_for_select_widget">
        <querytext>
    select dotlrn_terms.term_name || ' ' || dotlrn_terms.term_year,
           dotlrn_terms.term_id
    from dotlrn_terms
    where dotlrn_terms.end_date > (current_date - 360)
      and dotlrn_terms.start_date < (current_date + 360)
    order by dotlrn_terms.start_date,
             dotlrn_terms.end_date
        </querytext>
    </fullquery>
    
</queryset>
