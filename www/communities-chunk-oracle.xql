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
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_all_communities_count">
        <querytext>
            select count(*)
            from dotlrn_communities_not_closed dotlrn_communities
        </querytext>
    </fullquery>

  <fullquery name="select_current_memberships">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             1 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_active_communities dotlrn_communities,
           dotlrn_member_rels_approved
      where dotlrn_member_rels_approved.user_id = :user_id
      and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_all_memberships">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             1 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_communities dotlrn_communities,
           dotlrn_member_rels_approved
      where dotlrn_member_rels_approved.user_id = :user_id
      and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_current_non_memberships">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             0 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_active_comms_not_closed dotlrn_communities
      where not exists (select 1
                        from dotlrn_member_rels_full
                        where dotlrn_member_rels_full.user_id = :user_id
                        and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_all_non_memberships">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             0 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_communities_not_closed dotlrn_communities
      where not exists (select 1
                        from dotlrn_member_rels_full
                        where dotlrn_member_rels_full.user_id = :user_id
                        and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)
      and dotlrn_communities.parent_community_id is null
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_all_communities_count_by_type">
    <querytext>
      select count(*)
      from dotlrn_communities_not_closed dotlrn_communities
      where dotlrn_communities.community_type = :community_type
    </querytext>
  </fullquery>

  <fullquery name="select_current_memberships_by_type">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             1 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_active_communities dotlrn_communities,
           dotlrn_member_rels_approved
      where dotlrn_member_rels_approved.user_id = :user_id
      and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
      and dotlrn_communities.community_type = :community_type
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_all_memberships_by_type">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             1 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_communities dotlrn_communities,
           dotlrn_member_rels_approved
      where dotlrn_member_rels_approved.user_id = :user_id
      and dotlrn_member_rels_approved.community_id = dotlrn_communities.community_id
      and dotlrn_communities.community_type = :community_type
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_current_non_memberships_by_type">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             0 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_active_comms_not_closed dotlrn_communities
      where not exists (select 1
                        from dotlrn_member_rels_full
                        where dotlrn_member_rels_full.user_id = :user_id
                        and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)
      and dotlrn_communities.community_type = :community_type
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>

  <fullquery name="select_all_non_memberships_by_type">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             0 as member_p,
             decode(acs_permission.permission_p(:user_id, dotlrn_communities.community_id, 'admin'),'f',0,1) as admin_p,
             (select community_type
              from dotlrn_community_types
              where supertype = 'dotlrn_community'
              start with community_type = dotlrn_communities.community_type
              connect by community_type = prior supertype) as root_community_type
      from dotlrn_communities_not_closed dotlrn_communities
      where not exists (select 1
                        from dotlrn_member_rels_full
                        where dotlrn_member_rels_full.user_id = :user_id
                        and dotlrn_member_rels_full.community_id = dotlrn_communities.community_id)
      and dotlrn_communities.community_type = :community_type
      order by root_community_type, dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>
</queryset>
