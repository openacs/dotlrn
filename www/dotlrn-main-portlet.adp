<%

    #
    #  Copyright (C) 2001, 2002 MIT
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

<if @user_can_browse_p@>
  <small>[&nbsp;<a href="@dotlrn_url@/manage-memberships">#dotlrn.lt_JoinDrop_a_Class_or_C#</a>&nbsp;]</small>
  <br></br>
</if>

<if @communities:rowcount@ gt 0>

<multiple name="communities">

<%
    set old_level 0
    set new_level 0
    set depth 0
%>

<h3>
  <if @communities.simple_community_type@ eq "dotlrn_class_instance">
    <%= [parameter::get -localize -parameter class_instances_pretty_plural] %>:
  </if>
  <else>
    <%= [parameter::get -localize -parameter clubs_pretty_plural] %>:
  </else>
</h3>

<group column="simple_community_type">

<% set new_level $communities(tree_level) %>

  <if @new_level@ lt @old_level@>
    <% incr depth -1 %>
    </ul>
	<if @new_level@ eq 1 and @depth@ gt 1>
	<% while {$depth > 1} {	
		append close_tags "</ul>" 
		incr depth -1 
	} 
	%>
	@close_tags@
        </if>
     </if>

  <if @new_level@ gt @old_level@>
<% incr depth 1 %>
    <ul>
	<nobr>
  </if>

      <li>
        <nobr>
          <a href="@communities.url@">@communities.pretty_name@</a>
	<if @show_buttons_p@ eq 1>
		&nbsp; <small> 
                        <a href="@communities.url@deregister?referer=@referer@">#dotlrn.drop_membership_link#</a>
                      </small>
		<if @communities.admin_p@ eq 1>
                  &nbsp; <small>
                           <a href="@communities.url@one-community-admin">#dotlrn.administer_link#</a>
                         </small>
		</if>
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

</if>
