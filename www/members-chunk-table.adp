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

<h3>Members of <%= [dotlrn_community::get_community_name $community_id] %></h3>

@table@

<ul>

<if @admin_p@ eq 1 and @subcomm_p@ eq 0>
  <br>
  <li>
    <form method="get" action="member-add">
      Add A Member: <input type="text" name="search_text"><input type="submit" value="search">
      <input type="hidden" name="referer" value="@referer@">
    </form>
  </li>
</if>
<if @site_wide_admin_p@ eq 1>
<% set dotlrn_admin_url [dotlrn::get_admin_url] %>
  <br>
  <li>
    <a href="@dotlrn_admin_url@/users-add-to-community?users=@user_list@&referer=@referer@">
      Add members to another group
    </a>
  </li>
</if>

</ul>

<if @admin_p@ eq 1 and @pending_users:rowcount@ gt 0>

<h3>Membership Requests</h3>

<ul>
<multiple name="pending_users">
  <li>
    <%= [acs_community_member_link -user_id $pending_users(user_id) -label "$pending_users(first_names) $pending_users(last_name)"] %>
<if @read_private_data_p@ eq 1 or @user_id@ eq @pending_users.user_id@>
    (<a href="mailto:@pending_users.email@">@pending_users.email@</a>)
</if>
    &nbsp;
    <i>@pending_users.role@</i>
    &nbsp;
    [<small>
      <include src="approve-link" url="approve?user_id=@pending_users.user_id@&referer=@referer@">
      |
      <include src="reject-link" url="reject?user_id=@pending_users.user_id@&referer=@referer@">
    </small>]
  </li>
</multiple>
</ul>

</if>

<if @admin_p@ eq 1 and @subcomm_p@ eq 1 and @n_parent_users@ gt 0>

  <hr>

  <h3>Add New Members</h3>

  <blockquote>
    <p>
      The following members of 
      <%= [dotlrn_community::get_parent_name -community_id $community_id] %> 
      are not yet members of 
      <%= [dotlrn_community::get_community_name $community_id] %>.
    </p>

    <p>
      First check the box of the users you want to add, next select their
      role, and finally submit the form.
    </p>
  </blockquote>

<formtemplate id="parent_users_form">
  <table width="75%" border="0">

    <tr>
      <td width="15%" align="center"><strong>Don't Add</strong></td>
      <td width="15%" align="center"><strong>Member</strong></td>
      <td width="15%" align="center"><strong>Administrator</strong></td>
      <td>&nbsp;</td>
    </tr>

<%
    foreach user $parent_user_list {
        set this_user_id [ns_set get $user user_id]
        set this_first_names [ns_set get $user first_names]
        set this_last_name [ns_set get $user last_name]
        set this_email [ns_set get $user email]
%>

    <tr>
<formgroup id="selected_user.@this_user_id@" cols="3">
      <td width="15%" align="center">@formgroup.widget@</td>
</formgroup>
      <td>@this_last_name@, @this_first_names@ (@this_email@)</td>
    </tr>

<%
    }
%>

    <tr><td colspan="4">&nbsp;</td></tr>

    <tr>
      <td><input type="submit" value="Add Selected Members"></td>
      <td colspan="3">&nbsp;</td>
    </tr>

  </table>
</formtemplate>

</if>
