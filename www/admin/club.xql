<?xml version="1.0"?>

<queryset>
  <fullquery name="select_club">
    <querytext>
      select dotlrn_communities.pretty_name,
             dotlrn_communities.description
      from dotlrn_clubs,
           dotlrn_communities
      where dotlrn_clubs.club_id = :club_id
      and dotlrn_communities.community_id = :club_id
    </querytext>
  </fullquery>
</queryset>
