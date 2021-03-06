<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="select_member_subgroups">
        <querytext>
            select dotlrn_communities.*,
                   dotlrn_community__url(dotlrn_communities.community_id) as url,
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   '' as role_pretty_name
            from dotlrn_communities,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.user_id = :user_id
            and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
            and dotlrn_communities.community_type = 'dotlrn_community'
            order by dotlrn_communities.pretty_name,
                     dotlrn_communities.community_key
        </querytext>
    </fullquery>

</queryset>
