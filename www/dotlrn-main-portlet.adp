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

<%
    set old_simple_community_type ""
    set new_simple_community_type ""
    set old_level 0
    set new_level 0
%>

<multiple name="communities">

<%
    if {![string equal $communities(simple_community_type) "dotlrn_community"] == 1} {
        set new_simple_community_type $communities(simple_community_type)
    }
    set new_level $communities(level)
%>

    <if @new_level@ lt @old_level@>
      </ul>
    </if>

    <if @new_simple_community_type@ ne @old_simple_community_type@>
      <if @old_simple_community_type@ ne "">
        </ul>
        <br>
<% set old_level [expr $new_level - 1] %>
      </if>
      <if @new_simple_community_type@ eq "dotlrn_class_instance">
        <li><%= [parameter::get -parameter class_instances_pretty_plural] %>:
      </if>
      <else>
        <li><%= [parameter::get -parameter clubs_pretty_plural] %>:
      </else>
    </if>

    <if @new_level@ gt @old_level@>
      <ul>
    </if>

      <li>
        <a href="@communities.url@">@communities.pretty_name@</a>
        <if @communities.admin_p@ eq t> 
          [<small>
            <a href="@communities.url@one-community-admin">Administer</a>
          </small>]
        </if>
      </li>

<%
    set old_simple_community_type $new_simple_community_type
    set old_level $new_level
%>

</multiple>

<%
    for {set i $new_level} {$i > 0} {incr i -1} {
        template::adp_puts "</ul>\n"
    }
%>

  </ul>

</if>
