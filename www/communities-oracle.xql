<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_communities">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             (select site_node.url(site_nodes.node_id)
              from site_nodes
              where site_nodes.object_id = dotlrn_communities.package_id) as url,
             (select decode(count(*), 0, 'f', 't')
              from dotlrn_member_rels_full
              where dotlrn_member_rels_full.user_id = :user_id
              and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id) as member_p,
             acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin') as admin_p
      from dotlrn_active_not_closed_comms dotlrn_communities
      where dotlrn_communities.community_type = :community_type
    </querytext>
  </fullquery>
</queryset>
