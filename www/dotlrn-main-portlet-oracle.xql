<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_communities">
        <querytext>
            select dotlrn_communities.*,
                   dotlrn_community.url(dotlrn_communities.community_id) as url,
                   decode(dotlrn_communities.community_type, 'dotlrn_community', 'dotlrn_community',
                                                             'dotlrn_club', 'dotlrn_club',
                                                             'dotlrn_class_instance') as simple_community_type,
                   tree.tree_level(dotlrn_communities.tree_sortkey) as tree_level,
                   acs_permission.permission_p(dotlrn_communities.community_id, :user_id, 'admin') as admin_p
            from dotlrn_communities,
                 dotlrn_member_rels_approved
            where dotlrn_communities.community_id = dotlrn_member_rels_approved.community_id
            and dotlrn_member_rels_approved.user_id = :user_id
            order by dotlrn_communities.tree_sortkey
        </querytext>
    </fullquery>

</queryset>
