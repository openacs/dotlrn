<?xml version="1.0"?>

<queryset>
  <fullquery name="select_community_info">
    <querytext>
      select dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             groups.join_policy
      from dotlrn_communities,
           groups
      where dotlrn_communities.community_id = :community_id
      and groups.group_id = :community_id
    </querytext>
  </fullquery>
</queryset>
