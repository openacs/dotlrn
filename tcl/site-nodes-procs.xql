<?xml version="1.0"?>
<queryset>
  <fullquery name="select_parent_site_node">
    <querytext>
      select parent_id
      from site_nodes
      where node_id = :node_id
    </querytext>
  </fullquery>
</queryset>
