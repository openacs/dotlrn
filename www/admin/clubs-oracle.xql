<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

  <fullquery name="select_clubs">
    <querytext>
      select dotlrn_clubs.club_id,
             dotlrn_communities.community_key,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_community.url(dotlrn_communities.community_id) as url
      from dotlrn_clubs,
           dotlrn_communities
      where dotlrn_clubs.club_id = dotlrn_communities.community_id
    </querytext>
  </fullquery>
</queryset>
