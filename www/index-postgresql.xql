<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="select_classes">
<querytext>
select class_key, node_id, site_node__url(node_id) as url from dotlrn_classes order by class_key
</querytext>
</fullquery>

</queryset>
