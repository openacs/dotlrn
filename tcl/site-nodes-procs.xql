<?xml version="1.0"?>
<queryset>

    <fullquery name="site_nodes::get_parent_name_not_cached.select_parent_name_by_id">
        <querytext>
            select instance_name
            from apm_packages
            where package_id = (select object_id 
                                from site_nodes 
                                where node_id = (select parent_id 
                                                 from site_nodes 
                                                 where object_id = :instance_id))
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_parent_id.select_parent_by_node_id">
        <querytext>
            select parent_id
            from site_nodes
            where node_id = :node_id
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_parent_id.select_parent_by_instance_id">
        <querytext>
            select parent_id
            from site_nodes
            where object_id = :instance_id
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_parent_object_id.select_parent_oid_by_instance_id">
        <querytext>
            select object_id
            from site_nodes
            where node_id = (select parent_id
                             from site_nodes
                             where object_id = :instance_id)
        </querytext>
    </fullquery>

</queryset>
