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
                                                 where object_id = :package_id))
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_parent_id.select_parent_by_node_id">
        <querytext>
            select parent_id
            from site_nodes
            where node_id = :node_id
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_parent_id.select_parent_by_package_id">
        <querytext>
            select parent_id
            from site_nodes
            where object_id = :package_id
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_parent_object_id.select_parent_oid_by_package_id">
        <querytext>
            select object_id
            from site_nodes
            where node_id = (select parent_id
                             from site_nodes
                             where object_id = :package_id)
        </querytext>
    </fullquery>

    <fullquery name="site_nodes::get_child_package_id.select_child_package_id">
        <querytext>
            select sn1.object_id
            from site_nodes sn1,
                 apm_packages
            where sn1.parent_id = (select sn2.node_id
                                   from site_nodes sn2
                                   where sn2.object_id = :parent_package_id)
            and sn1.object_id = apm_packages.package_id
            and apm_packages.package_key = :package_key
        </querytext>
    </fullquery>

</queryset>
