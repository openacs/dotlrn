<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_n_member_classes">
        <querytext>
            select count(*)
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select acs_rel_roles.pretty_name
                    from acs_rel_roles
                    where acs_rel_roles.role = (select acs_rel_types.role_two
                                                from acs_rel_types
                                                where acs_rel_types.rel_type = dotlrn_member_rels_full.rel_type)) as role,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select acs_rel_roles.pretty_name
                    from acs_rel_roles
                    where acs_rel_roles.role = (select acs_rel_types.role_two
                                                from acs_rel_types
                                                where acs_rel_types.rel_type = dotlrn_member_rels_full.rel_type)) as role,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_class_instances_full.department_key = :member_department_key
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select acs_rel_roles.pretty_name
                    from acs_rel_roles
                    where acs_rel_roles.role = (select acs_rel_types.role_two
                                                from acs_rel_types
                                                where acs_rel_types.rel_type = dotlrn_member_rels_full.rel_type)) as role,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_class_instances_full.term_id = :member_term_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_classes_by_department_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   (select acs_rel_roles.pretty_name
                    from acs_rel_roles
                    where acs_rel_roles.role = (select acs_rel_types.role_two
                                                from acs_rel_types
                                                where acs_rel_types.rel_type = dotlrn_member_rels_full.rel_type)) as role,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_class_instances_full.department_key = :member_department_key
            and dotlrn_class_instances_full.term_id = :member_term_id
            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   (select acs_rel_roles.pretty_name
                    from acs_rel_roles
                    where acs_rel_roles.role = (select acs_rel_types.role_two
                                                from acs_rel_types
                                                where acs_rel_types.rel_type = dotlrn_member_rels_full.rel_type)) as role,
                   acs_permission.permission_p(dotlrn_clubs_full.club_id, :user_id, 'admin') as admin_p
            from dotlrn_clubs_full,
                 dotlrn_member_rels_full
            where dotlrn_member_rels_full.user_id = :user_id
            and dotlrn_member_rels_full.community_id = dotlrn_clubs_full.club_id
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_n_non_member_classes">
        <querytext>
            select count(*)
            from dotlrn_class_instances_full
            where not exists (select 1
                              from dotlrn_member_rels_full
                              where dotlrn_member_rels_full.user_id = :user_id
                              and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where not exists (select 1
                              from dotlrn_member_rels_full
                              where dotlrn_member_rels_full.user_id = :user_id
                              and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes_by_department">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :non_member_department_key
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.term_id = :non_member_term_id
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_classes_by_department_by_term">
        <querytext>
            select dotlrn_class_instances_full.*,
                   acs_permission.permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full
            where dotlrn_class_instances_full.department_key = :non_member_department_key
            and dotlrn_class_instances_full.term_id = :non_member_term_id
            and not exists (select 1
                            from dotlrn_member_rels_full
                            where dotlrn_member_rels_full.user_id = :user_id
                            and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id)
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_non_member_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   acs_permission.permission_p(dotlrn_clubs_full.club_id, :user_id, 'admin') as admin_p
            from dotlrn_clubs_full
            where not exists (select 1
                              from dotlrn_member_rels_full
                              where dotlrn_member_rels_full.user_id = :user_id
                              and dotlrn_member_rels_full.community_id = dotlrn_clubs_full.club_id)
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.community_key
        </querytext>
    </fullquery>

</queryset>
