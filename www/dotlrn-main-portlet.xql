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
  <fullquery name="select_classes">
    <querytext>
      select community_id, 
             dotlrn_class_instances_full.pretty_name,
             dotlrn_class_instances_full.url,
             acs_permission.permission_p(community_id, :user_id, 'admin') as admin_p
      from dotlrn_class_instances_full,
           dotlrn_member_rels_approved
      where dotlrn_member_rels_approved.user_id = :user_id
      and dotlrn_member_rels_approved.community_id = dotlrn_class_instances_full.class_instance_id
    </querytext>
  </fullquery>

  <fullquery name="select_clubs">
    <querytext>
      select community_id, 
             dotlrn_clubs_full.pretty_name,
             dotlrn_clubs_full.url,
             acs_permission.permission_p(community_id, :user_id, 'admin') as admin_p
      from dotlrn_clubs_full,
           dotlrn_member_rels_approved
      where dotlrn_member_rels_approved.user_id = :user_id
      and dotlrn_member_rels_approved.community_id = dotlrn_clubs_full.club_id
    </querytext>
  </fullquery>
</queryset>
