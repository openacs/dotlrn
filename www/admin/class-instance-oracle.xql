<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_class_instance">
    <querytext>
      select dotlrn_communities.pretty_name,
             (select site_node.url(site_nodes.node_id)
              from site_nodes
              where site_nodes.object_id = dotlrn_communities.package_id) as url
      from dotlrn_active_comms dotlrn_communities
      where dotlrn_communities.community_id = :class_instance_id
    </querytext>
  </fullquery>
</queryset>
