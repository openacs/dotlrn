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
    #dotlrn.Person_name#
    @first_names@ @last_name@
  <if @oacs_site_wide_admin_p@ true> 
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotlrn.Edit#</a> </small>]
  </if>
  </li>

  <li>
    #dotlrn.Email#
    <a href="mailto:@email@">@email@</a>
  <if @oacs_site_wide_admin_p@ true>
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotlrn.Edit#</a> </small>]
  </if> 
  </li>

  <li>
    #dotlrn.Screen_name#
    @screen_name@
  <if @oacs_site_wide_admin_p@ true>
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">#dotlrn.Edit#</a> </small>]
  </if>
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
<else>
  <li>
    #dotlrn.lt_Last_Visit_None_#: @remove_user_url;noquote@
  </li>
</else>

<if @portrait_p@ eq 1>
  <li>
    #dotlrn.Portrait# <a href="/shared/portrait?user_id=@user_id@">@portrait_title@</a>
  </li>
</if>

  <li>
    #dotlrn.Member_state#
    @member_state@
  <if @oacs_site_wide_admin_p@ true> 
    @change_state_links;noquote@
  </if>
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
    <if @can_browse_p@>#dotlrn.Full# [ <small><a href="browse-toggle?user_id=@user_id@&can_browse_p=0&referer=@return_url@">#dotlrn.Limited#</a> </small>]</if><else>#dotlrn.Limited# [ <small><a href="browse-toggle?user_id=@user_id@&can_brow
se_p=1&referer=@return_url@">#dotlrn.Full#</a> </small>]</else>
  </li>

  <li>
    #dotlrn.Guest#
    <if @guest_p@ eq t>#dotlrn.Yes# [ <small><a href="guest-toggle?user_id=@user_id@&guest_p=f&referer=@return_url@">#dotlrn.No#</a> </small>]</if><else>#dotlrn.No# [ <small><a href="guest-toggle?user_id=@user_id@&guest_p=t&referer=@return_url@">#dotlrn.Yes#</a> </small>]</else>
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
    <li><a href="/user/portrait/index.tcl?@export_edit_vars@">#dotlrn.lt_Manage_this_users_por#</a></li>
  </if>

 <if @oacs_site_wide_admin_p@ true>
  <li><a href="/acs-admin/users/become?user_id=@user_id@">#dotlrn.Become_this_user#</a></li>
 </if> 
</ul>
