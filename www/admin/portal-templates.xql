<?xml version="1.0"?>

<queryset>

    <fullquery name="select_portal_templates">
        <querytext>
            select dptm.portal_id, p.name, fyck
            from portals p, dotlrn_portal_types_map dptm
            where p.portal_id = dptm.portal_id
            order by p.name descasdsfda
        </querytext>
    </fullquery>

</queryset>
