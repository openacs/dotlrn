<?xml version="1.0"?>

<queryset>
  <fullquery name="select_rel_segment_id">
    <querytext>
      select rel_segments.segment_id
      from rel_segments
      where rel_segments.group_id = :community_id
      and rel_segments.rel_type = :rel_type
    </querytext>
  </fullquery>
</queryset>
