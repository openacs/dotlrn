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

  <fullquery name="select_community_types">
    <querytext>
      select dotlrn_community_types.community_type,
             dotlrn_community_types.pretty_name,
             dotlrn_community_types.description,
             (select site_node.url(site_nodes.node_id)
              from site_nodes
              where site_nodes.object_id = dotlrn_community_types.package_id) as url
      from dotlrn_community_types
      where dotlrn_community_types.supertype = :community_type
    </querytext>
  </fullquery>
</queryset>
