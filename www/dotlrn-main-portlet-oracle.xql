<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_communities">
        <querytext>
            select dc.*,
                   dotlrn_community.url(dc.community_id) as url,
                   acs_permission.permission_p(dc.community_id, :user_id, 'admin') as admin_p,
                   decode(dc.community_type, 'dotlrn_community', 'dotlrn_community',
                                             'dotlrn_club', 'dotlrn_club',
                                             'dotlrn_class_instance') as simple_community_type
            from (select level,
                         dotlrn_communities.community_id,
                         dotlrn_communities.parent_community_id,
                         dotlrn_communities.community_type,
                         dotlrn_communities.pretty_name
                  from dotlrn_communities
                  connect by prior dotlrn_communities.community_id = dotlrn_communities.parent_community_id
                  start with dotlrn_communities.parent_community_id is null
                  order by decode(dotlrn_communities.community_type, 'dotlrn_community', 2, 'dotlrn_club', 1, 0),
                           dotlrn_communities.pretty_name) dc,
                 dotlrn_member_rels_approved dmra
            where dc.community_id = dmra.community_id
            and dmra.user_id = :user_id
        </querytext>
    </fullquery>

</queryset>
