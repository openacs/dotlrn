<?xml version="1.0"?>

<queryset>
  <fullquery name="select_clubs">
    <querytext>
      select dotlrn_clubs.club_id,
             dotlrn_communities.community_key,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description
      from dotlrn_clubs,
           dotlrn_communities
      where dotlrn_clubs.club_id = dotlrn_communities.community_id
    </querytext>
  </fullquery>
</queryset>
