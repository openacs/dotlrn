<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="select_dotlrn_user_info">
        <querytext>
            select dotlrn_users.*,
                   acs_permission__permission_p(:dotlrn_package_id, :user_id, 'read_private_data') as read_private_data_p
            from dotlrn_users
            where dotlrn_users.user_id = :user_id
        </querytext>
    </fullquery>

    <fullquery name="select_portrait_info">      
        <querytext>
            select cr_items.live_revision as revision_id,
                   coalesce(cr_revisions.title, 'view this portrait') portrait_title
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
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   '' as role_pretty_name,
                   acs_permission__permission_p(dotlrn_class_instances_full.class_instance_id, :user_id, 'admin') as admin_p
            from dotlrn_class_instances_full,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.user_id = :user_id
            and dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
            order by dotlrn_class_instances_full.department_name,
                     dotlrn_class_instances_full.department_key,
                     dotlrn_class_instances_full.pretty_name,
                     dotlrn_class_instances_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   '' as role_pretty_name,
                   acs_permission__permission_p(dotlrn_clubs_full.club_id, :user_id, 'admin') as admin_p
            from dotlrn_clubs_full,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.user_id = :user_id
            and dotlrn_member_rels_approved.community_id = dotlrn_clubs_full.club_id
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.community_key
        </querytext>
    </fullquery>

    <fullquery name="select_member_subgroups">
        <querytext>
            select dotlrn_communities.*,
                   dotlrn_community__url(dotlrn_communities.community_id) as url,
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   '' as role_pretty_name,
                   acs_permission__permission_p(dotlrn_communities.community_id, :user_id, 'admin') as admin_p
            from dotlrn_communities,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.user_id = :user_id
            and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
            and dotlrn_communities.community_type = 'dotlrn_community'
            order by dotlrn_communities.pretty_name,
                     dotlrn_communities.community_key
        </querytext>
    </fullquery>

</queryset>