<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="select_classes">
<querytext>
select class_key, node_id, site_node.url(node_id) as url from dotlrn_classes, dotlrn_community_types where dotlrn_community_types.community_type=dotlrn_classes.class_key order by class_key
</querytext>
</fullquery>

</queryset>
