<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_my_communities">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             (select pretty_name
              from acs_rel_roles
              where role = (select acs_rel_types.role_two
                            from acs_rel_types,
                                 acs_rels
                            where acs_rel_types.rel_type = acs_rels.rel_type
                            and acs_rels.rel_id = dotlrn_member_rels_full.rel_id)) as role,
             decode(dotlrn_community.admin_p(dotlrn_communities.community_id, dotlrn_member_rels_full.user_id),'f',0,1) as admin_p
      from dotlrn_communities,
           dotlrn_member_rels_full
      where dotlrn_communities.community_id = dotlrn_member_rels_full.community_id
      and dotlrn_member_rels_full.user_id = :user_id
      order by dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>
</queryset>
