<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

%>

<% set dotlrn_url [dotlrn::get_url] %>

<small>[&nbsp;<a href="@dotlrn_url@/manage-memberships">Join/Drop a Class or Community Group</a>&nbsp;]</small>

<if @communities:rowcount@ gt 0>

  <ul>
<multiple name="communities">

<%
    set old_level 0
    set new_level 0
    set depth 0
%>

  <if @communities.simple_community_type@ eq "dotlrn_class_instance">
    <li><%= [parameter::get -parameter class_instances_pretty_plural] %>:
  </if>
  <else>
    <li><%= [parameter::get -parameter clubs_pretty_plural] %>:
  </else>

<group column="simple_community_type">

<% set new_level $communities(tree_level) %>

  <if @new_level@ lt @old_level@>
<% incr depth -1 %>
    </ul>
  </if>

  <if @new_level@ gt @old_level@>
<% incr depth 1 %>
    <ul>
  </if>

      <li>
        <nobr>
          <a href="@communities.url@">@communities.pretty_name@</a>
          <if @communities.admin_p@ eq t> 
            [<small>
              <a href="@communities.url@one-community-admin">Administer</a>
            </small>]
          </if>
        </nobr>
      </li>

<% set old_level $new_level %>

</group>

<%
    for {set i $depth} {$i > 0} {incr i -1} {
        template::adp_puts "</ul>\n"
    }
%>

</multiple>
  </ul>

</if>
