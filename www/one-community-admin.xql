<?xml version="1.0"?>

<queryset>

    <fullquery name="select_community_info">
        <querytext>
            select community_type,
                   pretty_name,
                   description,
                   portal_template_id,
                   admin_portal_id
            from dotlrn_communities
            where community_id = :community_id
        </querytext>
    </fullquery>

</queryset>
