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

<master src="dotlrn-admin-master">
<property name="title">@first_names@ @last_name@</property>
<property name="context_bar">@context_bar@</property>

<h3>#dotlrn.General_Information#</h3>

<ul>

  <li>
    #dotlrn.Name#
    @first_names@ @last_name@
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotlrn.Edit#</a> </small>]
  </li>

  <li>
    #dotlrn.Email#
    <a href="mailto:@email@">@email@</a>
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotlrn.Edit#</a> </small>]
  </li>

  <li>
    #dotlrn.Screen_name#
    @screen_name@
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotlrn.Edit#</a> </small>]
  </li>

  <li>
    #dotlrn.User_ID#
    @user_id@
  </li>

  <li>
    #dotlrn.Registration_date#
    @registration_date@
  </li>

<if @last_visit@ not nil>
  <li>
    #dotlrn.Last_Visit#
    @last_visit@
  </li>
</if>

<if @portrait_p@ eq 1>
  <li>
    #dotlrn.Portrait# <a href="/shared/portrait?user_id=@user_id@">@portrait_title@</a>
  </li>
</if>

  <li>
    #dotlrn.Member_state#
    @member_state@
    @change_state_links;noquote@
  </li>

</ul>

<h3>#dotlrn.dotLRN_Information#</h3>

<if @dotlrn_user_p@>

<ul>

  <li>
    #dotlrn.User_type#
    <%= [lang::util::localize @pretty_type@] %>
  </li>

  <li>
    #dotlrn.Access_level#
    <if @can_browse_p@>#dotlrn.Full#</if><else>#dotlrn.Limited#</else>
  </li>

  <li>
    #dotlrn.Guest#
    <if @read_private_data_p@>#dotlrn.No#</if><else>#dotlrn.Yes#</else>
  </li>

  <li>
    #dotlrn.ID#
    <if @id@ nil>#dotlrn.ltnone_set_upgt#</if><else>@id@</else>
  </li>

  <br>

  <li>
    <a href="user-edit?@export_edit_vars@">#dotlrn.Edit#</a> #dotlrn.lt_dotLRN_properties_for#
  </li>

</ul>

<if @member_classes:rowcount@ gt 0>
  <blockquote>
    <h4>#dotlrn.class_memberships#</h4>

    <ul>
<multiple name="member_classes">
      <li>
        <a href="@member_classes.url@">@member_classes.pretty_name@</a>
        @member_classes.term_name@ @member_classes.term_year@
        (@member_classes.role_pretty_name@)
      </li>
</multiple>
    </ul>
  </blockquote>
</if>

<if @member_clubs:rowcount@ gt 0>
  <blockquote>
    <h4>#dotlrn.community_memberships#</h4>

    <ul>
<multiple name="member_clubs">
      <li>
        <a href="@member_clubs.url@">@member_clubs.pretty_name@</a>
        (@member_clubs.role_pretty_name@)
      </li>
</multiple>
    </ul>
  </blockquote>
</if>

<if @member_subgroups:rowcount@ gt 0>
  <blockquote>
    <h4>#dotlrn.subcommunity_memberships#</h4>

    <ul>
<multiple name="member_subgroups">
      <li>
        <a href="@member_subgroups.url@">@member_subgroups.pretty_name@</a>
        (@member_subgroups.role_pretty_name@)
      </li>
</multiple>
    </ul>
  </blockquote>
</if>

  <ul>
    <li>
      <a href="users-add-to-community?users=@user_id@&referer=@return_url@">#dotlrn.add_to_another_group#</a>
    </li>
  </ul>

</if>
<else>
<p>
<if @member_state@ eq "approved">
  <a href="user-new-2?user_id=@user_id@&referer=@return_url@">#dotlrn.add_to_dotlrn#</a>
</if>
<else>
#dotlrn.lt_This_user_is_currentl#.
</else>
</p>
</else>

<h3>#dotlrn.lt_Administrative_Action#</h3>

<ul>
  <li><a href="password-update?@export_edit_vars@">#dotlrn.lt_Update_this_users_pas#</a></li>
<if @portrait_p@>
  <br>
  <li><a href="/user/portrait/index.tcl?@export_edit_vars@">#dotlrn.lt_Manage_this_users_por#</a></li>
</if>
<if @dotlrn_user_p@ eq 1>
  <br>
  <li>    
<if @site_wide_admin_p@ eq t>
This user is a site-wide admin. (<a href="site-wide-admin-toggle?user_id=@user_id@&value=revoke&referer=@return_url@">revoke</a>)
    </if>
    <else>
      <a href="site-wide-admin-toggle?user_id=@user_id@&value=grant&referer=@return_url@">Make this user a site wide admin.</a>
    </else>
</if>
  <br>
  <li>    
<if @dotlrn_user_p@ eq 1>
<if @site_wide_admin_p@ eq t>
#dotlrn.lt_This_user_is_a_site-w# (<a href="site-wide-admin-toggle?user_id=@user_id@&value=revoke&referer=@return_url@">#dotlrn.revoke#</a>)
    </if>
    <else>
      <a href="site-wide-admin-toggle?user_id=@user_id@&value=grant&referer=@return_url@">#dotlrn.lt_Make_this_user_a_site#</a>
    </else>
</if>
  <br>
  <li><a href="/acs-admin/users/become?user_id=@user_id@">#dotlrn.Become_this_user#</a></li>
</ul>


