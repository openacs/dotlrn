<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="dotlrn_community::get_community_id_not_cached.select_community">
        <querytext>
            select dotlrn_communities.community_id
            from dotlrn_communities,
                 (select site_nodes.object_id
                 from site_nodes
                 where exists (select 1
                               from dotlrn_communities dc
                               where dc.package_id = site_nodes.object_id)
                 and rownum = 1
                 start with site_nodes.node_id = (select sn.node_id
                                                  from site_nodes sn
                                                  where sn.object_id = :package_id)
                 connect by prior site_nodes.parent_id = site_nodes.node_id) packages
            where dotlrn_communities.package_id = packages.object_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::new_type.create_community_type">
        <querytext>
            declare
            begin
                :1 := dotlrn_community_type.new(
                    community_type => :community_type_key,
                    parent_type => :parent_type,
                    pretty_name => :pretty_name,
                    pretty_plural => :pretty_name,
                    description => :description
                );
            end;
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::new.create_community">
        <querytext>
            declare
            begin
                :1 := dotlrn_community.new(
                    community_type => :community_type,
                    community_key => :name
                    pretty_name => :pretty_name,
                    pretty_plural => :pretty_name,
                    description => :description
                );
            end;
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::set_active_dates.set_active_dates">
        <querytext>
            declare
            begin
                dotlrn_community.set_active_dates(
                    community_id => :community_id,
                    start_date => to_date(:start_date, :date_format),
                    end_date => to_date(:end_date, :date_format)
                );
            end;
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::get_url.select_node_url">
        <querytext>
            select site_node.url(node_id)
            from site_nodes
            where parent_id = :current_node_id
            and object_id= :package_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::get_url_from_package_id_not_cached.select_node_url">
        <querytext>
            select site_node.url(node_id)
            from site_nodes
            where object_id = :package_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::get_community_type_from_community_id.select_community_type">
        <querytext>
            select community_type
            from dotlrn_communities
            where community_id = :community_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::get_toplevel_community_type_from_community_id.select_community_type">
        <querytext>
            select dotlrn_community_types.community_type
            from dotlrn_community_types
            where dotlrn_community_types.tree_sortkey = (select tree.ancestor_key(dotlrn_communities.tree_sortkey, 1)
                                                         from dotlrn_communities
                                                         where dotlrn_communities.community_id = :community_id)
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_community::get_toplevel_community_type.select_community_type">
        <querytext>
            select dotlrn_community_types.community_type
            from dotlrn_community_types
            where dotlrn_community_types.tree_sortkey = (select tree.ancestor_key(dct.tree_sortkey, 1)
                                                         from dotlrn_community_types dct
                                                         where dct.community_type = :community_type)
        </querytext>
    </fullquery>

</queryset>
