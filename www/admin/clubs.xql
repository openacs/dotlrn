<?xml version="1.0"?>

<queryset>

    <fullquery name="select_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_clubs_full.club_id) as n_members
            from dotlrn_clubs_full
            order by dotlrn_clubs_full.pretty_name,
                     dotlrn_clubs_full.description
        </querytext>
    </fullquery>

</queryset>
