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

  <fullquery name="select_my_communities">
    <querytext>
      select dotlrn_communities.community_id,
             dotlrn_communities.community_type,
             dotlrn_communities.pretty_name,
             dotlrn_communities.description,
             dotlrn_communities.package_id,
             dotlrn_community.url(dotlrn_communities.community_id) as url,
             dotlrn_member_rels_approved.role,
             decode(dotlrn_community.admin_p(dotlrn_communities.community_id, dotlrn_member_rels_approved.user_id),'f',0,1) as admin_p
      from dotlrn_communities,
           dotlrn_member_rels_approved
      where dotlrn_communities.community_id = dotlrn_member_rels_approved.community_id
      and dotlrn_member_rels_approved.user_id = :user_id
      order by dotlrn_communities.community_type, dotlrn_communities.pretty_name
    </querytext>
  </fullquery>
</queryset>
