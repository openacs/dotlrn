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

  <fullquery name="site_nodes::get_parent_name.select_parent_name_by_id">
    <querytext>
    select instance_name
    from apm_packages
    where package_id= (select object_id 
                       from site_nodes 
                       where node_id= (select parent_id 
                                       from site_nodes 
                                       where object_id=:instance_id))
    </querytext>
  </fullquery>

  <fullquery name="site_nodes::get_parent_id.select_parent_by_node_id">
    <querytext>
      select parent_id
      from site_nodes
      where node_id = :node_id
    </querytext>
  </fullquery>

  <fullquery name="site_nodes::get_parent_id.select_parent_by_instance_id">
    <querytext>
      select parent_id
      from site_nodes
      where object_id = :instance_id
    </querytext>
  </fullquery>

  <fullquery name="site_nodes::get_parent_object_id.select_parent_oid_by_instance_id">
    <querytext>
      select object_id from site_nodes where node_id =  (select parent_id
      from site_nodes
      where object_id = :instance_id)
    </querytext>
  </fullquery>

</queryset>
