<?xml version="1.0"?>

<queryset>
  <fullquery name="select_classes">
    <querytext>
      select dotlrn_class_instances_full.pretty_name,
             dotlrn_class_instances_full.url
      from dotlrn_class_instances_full,
           dotlrn_member_rels_full
      where dotlrn_member_rels_full.user_id = :user_id
      and dotlrn_member_rels_full.community_id = dotlrn_class_instances_full.class_instance_id
    </querytext>
  </fullquery>

  <fullquery name="select_clubs">
    <querytext>
      select dotlrn_clubs_full.pretty_name,
             dotlrn_clubs_full.url
      from dotlrn_clubs_full,
           dotlrn_member_rels_full
      where dotlrn_member_rels_full.user_id = :user_id
      and dotlrn_member_rels_full.community_id = dotlrn_clubs_full.club_id
    </querytext>
  </fullquery>
</queryset>
