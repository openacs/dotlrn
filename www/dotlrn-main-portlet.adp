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


<small>[<a href="/dotlrn/manage-memberships">Join/Drop a Class or Community Group</a>]</small>

<if @classes:rowcount@ gt 0 or @clubs:rowcount@ gt 0>
<ul>
</if>

<if @classes:rowcount@ gt 0>
 <li><%= [ad_parameter class_instances_pretty_plural] %>:
  <ul>
    <multiple name="classes">
      <li>
        <a href="@classes.url@">@classes.pretty_name@</a>
        <if @classes.admin_p@ eq t> 
          <small>[<a href="@classes.url@one-community-admin">admin</a>]</small>
        </if>
      </li>
        <if @classes.subcomm_p@ eq t>
          <ul>
            <%= [dotlrn_community::get_subcomm_chunk_new -user_id $user_id -community_id $classes(community_id) -only_member_p 1] %>
          </ul>
        </if>
    </multiple>
  </ul>
</if>

<if @clubs:rowcount@ gt 0>
 <li><%= [ad_parameter clubs_pretty_plural] %>:
  <ul>
    <multiple name="clubs">
      <li>
        <a href="@clubs.url@">@clubs.pretty_name@</a>
        <if @clubs.admin_p@ eq t> 
            <small>[<a href="@clubs.url@one-community-admin">admin</a>]</small>
        </if>
      </li>
        <if @clubs.subcomm_p@ eq t>
          <ul>
            <%= [dotlrn_community::get_subcomm_chunk_new -user_id $user_id -community_id $clubs(community_id) -only_member_p 1] %>
          </ul>
        </if>
    </multiple>
  </ul>
</if>

<if @classes:rowcount@ gt 0 or @clubs:rowcount@ gt 0>
</ul>
</if>

