<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_dotlrn_user_info">
        <querytext>
            select dotlrn_users.id,
                   dotlrn_users.type,
                   dotlrn_user_types.pretty_name as pretty_type,
                   case when dotlrn_full_user_profile_rels.rel_id is null then 'Limited' else 'Full' end as access_level,
                   acs_permission.permission_p(:dotlrn_package_id, :user_id, 'read_private_data') as read_private_data_p
            from dotlrn_users,
                 dotlrn_full_user_profile_rels,
                 dotlrn_user_types
            where dotlrn_users.user_id = :user_id
            and dotlrn_users.rel_id = dotlrn_full_user_profile_rels.rel_id(+)
            and dotlrn_users.type = dotlrn_user_types.type
        </querytext>
    </fullquery>

    <fullquery name="select_portrait_info">      
        <querytext>
            select cr_items.live_revision as revision_id,
                   nvl(cr_revisions.title, 'view this portrait') portrait_title
            from acs_rels,
                 cr_items,
                 cr_revisions
            where acs_rels.object_id_two = cr_items.item_id
            and cr_items.live_revision = cr_revisions.revision_id
            and acs_rels.object_id_one = :user_id
            and acs_rels.rel_type = 'user_portrait_rel'
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

</queryset>
