<?xml version="1.0"?>

<queryset>

    <fullquery name="dotlrn::get_users_rel_segment_id.select_user_rel_segment">
        <querytext>
            select segment_id
            from rel_segments
            where segment_name = 'dotLRN Users'
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::get_user_theme_not_cached.select_user_theme">
        <querytext>
            select theme_id
            from dotlrn_users
            where user_id = :user_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::set_user_theme.update_user_theme">
        <querytext>
            update dotlrn_user_profile_rels
            set theme_id = :theme_id
            where rel_id = (select rel_id
                            from dotlrn_users
                            where user_id = :user_id)
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::get_portal_id_not_cached.select_user_portal_id">
        <querytext>
            select portal_id
            from dotlrn_users
            where user_id = :user_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::instantiate_and_mount.select_node_id">
        <querytext>
            select node_id
            from site_nodes
            where object_id = :package_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::get_group_id_from_user_type.select_group_id_from_user_type">
        <querytext>
            select dotlrn_user_types.group_id
            from dotlrn_user_types
            where dotlrn_user_types.type = :type
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::set_type_portal_id.insert">
        <querytext>
            insert into dotlrn_portal_types_map
            (type, portal_id)
            values
            (:type, :portal_id)
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::get_type_from_portal_id.select">
        <querytext>
            select type from dotlrn_portal_types_map where portal_id = :portal_id
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::get_portal_id_from_type.select">
        <querytext>
            select portal_id from dotlrn_portal_types_map where type = :type
        </querytext>
    </fullquery>

    <fullquery name="dotlrn::instantiate_and_mount.package_pretty_name">
        <querytext>
            select pretty_name 
            from   apm_package_types 
            where  package_key = :package_key 
        </querytext>
    </fullquery>

</queryset>
