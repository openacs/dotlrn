<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


<queryset>
  <fullquery name="select_rel_segment_id">
    <querytext>
      select rel_segments.segment_id
      from rel_segments
      where rel_segments.group_id = :community_id
      and rel_segments.rel_type = :rel_type
    </querytext>
  </fullquery>

  <fullquery name="select_recepients">
    <querytext>
      select parties.party_id
      from party_approved_member_map,
           parties
      where party_approved_member_map.party_id = :segment_id
      and party_approved_member_map.member_id <> :segment_id
      and party_approved_member_map.member_id = parties.party_id
    </querytext>
  </fullquery>

  <fullquery name="select_recepient_info">
    <querytext>
      select parties.email,
             decode(acs_objects.object_type,
                    'user',
                    (select first_names
                     from persons
                     where person_id = parties.party_id),
                    'group',
                    (select group_name
                     from groups
                     where group_id = parties.party_id),
                    'rel_segment',
                    (select segment_name
                     from rel_segments
                     where segment_id = parties.party_id),
                    '') as first_names,
             decode(acs_objects.object_type,
                    'user',
                    (select last_name
                     from persons
                     where person_id = parties.party_id),
                    '') as last_name
      from party_approved_member_map,
           parties,
           acs_objects
      where party_approved_member_map.party_id = :segment_id
      and party_approved_member_map.member_id <> :segment_id
      and party_approved_member_map.member_id = parties.party_id
      and parties.party_id = acs_objects.object_id
    </querytext>
  </fullquery>

</queryset>
