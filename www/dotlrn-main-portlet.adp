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


<if @user_can_browse_p@ and @self_registration_p@>
  <small>[&nbsp;<a href="@dotlrn_url@/manage-memberships" title="#dotlrn.lt_JoinDrop_a_Class_or_C#">#dotlrn.lt_JoinDrop_a_Class_or_C#</a>&nbsp;]</small>
  <br></br>
</if>

<if @communities:rowcount@ gt 0>

<multiple name="communities">
@communities.previous_type_ul_tags;noquote@

<ul class="mktree" style="padding-left: 5px;"><li id="dotlrn-main-@communities.simple_community_type@" remember="1">
<h3 style="display: inline; margin: 5px 0 0 0;">
  <if @communities.simple_community_type@ eq "dotlrn_class_instance">
    <%= [parameter::get -localize -parameter class_instances_pretty_plural] %>
  </if>
  <else>
    <%= [parameter::get -localize -parameter clubs_pretty_plural] %>
  </else>

</h3><small>( <a href="#" style="text-decoration: none; border: 0;" onClick="expandTree('tree-@communities.simple_community_type@'); this.parentNode.parentNode.className = nodeOpenClass; return false;">++</a> | <a href="#" style="text-decoration: none; border: 0;"  onClick="collapseTree('tree-@communities.simple_community_type@'); this.parentNode.parentNode.className = nodeClosedClass; return false;">--</a> )</small>

<ul id="tree-@communities.simple_community_type@"><li>
<group column="simple_community_type">

@communities.intra_type_ul_tags;noquote@

          <a href="@communities.url@" title="#dotlrn.goto_communities_pretty_name_portal#">@communities.pretty_name@</a>
	<if @communities.archived_p@><font color=red>Archived</font></if>
	<if @show_buttons_p@ eq 1>
           <if @show_drop_button_p@ eq 1>
		&nbsp; <small> 
                        <a href="@communities.url@deregister?referer=@referer@">#dotlrn.drop_membership_link#</a>
                      </small>
           </if>
           <if @communities.admin_p@ eq 1>
                  &nbsp; <small>
                           <a href="@communities.url@one-community-admin">#dotlrn.administer_link#</a>
                         </small>
	   </if>
	</if>

</group>
</li></ul></li></ul>

</multiple>

@final_ul_tags;noquote@

</if>
