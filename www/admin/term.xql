<?xml version="1.0"?>

<queryset>

    <fullquery name="select_term_info">
        <querytext>
            select term_name,
                   term_year,
                   to_char(start_date, 'Mon DD YYYY') as start_date,
                   to_char(end_date, 'Mon DD YYYY') as end_date
            from dotlrn_terms
            where term_id = :term_id
        </querytext>
    </fullquery>

    <fullquery name="select_classes">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.term_id = :term_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.term_id = :term_id
            and dotlrn_class_instances_full.department_key = :department_key
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_all_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id) as n_members
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :department_key
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.class_name,
                     dotlrn_class_instances_full.class_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

</queryset>
