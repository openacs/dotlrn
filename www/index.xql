<?xml version="1.0"?>

<queryset>

<fullquery name="select_classes">
<querytext>
select class_key, node_id, site_node.url(node_id) from dotlrn_classes, dotlrn_community_types where dotlrn_community_types.community_type=dotlrn_classes.class_key order by class_key
</querytext>
</fullquery>

</queryset>
