<?xml version="1.0"?>

<queryset>

    <fullquery name="select_portal_templates">
        <querytext>
            select p.portal_id,
                   name
            from portals p,
                 dotlrn_communities dc
            where dc.portal_id = p.portal_id
            and dc.non_member_portal_id is null
            and dc.admin_portal_id is null
            and dc.community_type != 'user_workspace'
        </querytext>
    </fullquery>

</queryset>
