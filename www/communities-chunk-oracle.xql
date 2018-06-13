<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
  
    <fullquery name="select_all_memberships">
        <querytext>
            select dotlrn_communities.community_id,
                   dotlrn_communities.community_type,
                   dotlrn_communities.pretty_name,
                   dotlrn_communities.description,
                   dotlrn_communities.package_id,
                   1 as member_p,
                   (select dotlrn_community_types.community_type
                    from dotlrn_community_types
                    where dotlrn_community_types.tree_sortkey = tree.ancestor_key(dotlrn_communities.tree_sortkey, 1)) as root_community_type                   
            from dotlrn_communities dotlrn_communities,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.user_id = :user_id
            and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
            and (:community_type is null or dotlrn_communities.community_type = :community_type)
            order by root_community_type,
                     dotlrn_communities.community_type,
                     dotlrn_communities.pretty_name
        </querytext>
    </fullquery>

    <fullquery name="select_all_non_memberships">
        <querytext>
            select dotlrn_communities.community_id,
                   dotlrn_communities.community_type,
                   dotlrn_communities.pretty_name,
                   dotlrn_communities.description,
                   dotlrn_communities.package_id,
                   0 as member_p,
                   (select dotlrn_community_types.community_type
                    from dotlrn_community_types
                    where dotlrn_community_types.tree_sortkey = tree_ancestor_key(dotlrn_communities.tree_sortkey, 1)) as root_community_type                   
            from dotlrn_communities_not_closed dotlrn_communities
            where not exists (select 1
                              from dotlrn_member_rels_full
                              where dotlrn_member_rels_full.user_id = :user_id
                              and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)
            and (:community_type is null or dotlrn_communities.community_type = :community_type)
            order by root_community_type,
                     dotlrn_communities.community_type,
                     dotlrn_communities.pretty_name
        </querytext>
    </fullquery>

</queryset>
