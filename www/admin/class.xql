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

    <fullquery name="select_all_class_instances">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.class_key = :class_key 
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
            and dotlrn_class_instances_full.term_id = :term_id
            [template::list::orderby_clause -orderby -name "class_instances"]
        </querytext>
    </fullquery>

</queryset>
