<?xml version="1.0"?>

<queryset>

    <fullquery name="select_clubs">
        <querytext>
            select dotlrn_clubs_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_clubs_full.club_id) as n_members
            from dotlrn_clubs_full
	    where 1 = 1
	    [template::list::page_where_clause -and -name "clubs" -key "dotlrn_clubs_full.club_id"]
	    [template::list::orderby_clause -orderby -name "clubs"]
        </querytext>
    </fullquery>

    <fullquery name="clubs_pagination">
        <querytext>
            select dotlrn_clubs_full.*,
                   (select count(*)
                    from dotlrn_member_rels_approved
                    where dotlrn_member_rels_approved.community_id = dotlrn_clubs_full.club_id) as n_members
            from dotlrn_clubs_full
            [template::list::orderby_clause -orderby -name "clubs"]
        </querytext>
    </fullquery>

</queryset>
