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

<if @admin_p@ eq 1 and @subcomm_p@ eq 0>
<form method="get" action="member-add">
   Add A Member: <input type="text" name="search_text"><input type="submit" value="search">
   <input type="hidden" name="referer" value="@referer@">
</form>


<form method="post" action="deregister-confirm">
</if>


<table  width="85%" class="table-display" cellpadding="5" cellspacing="0">
    <tr class="table-header">
      <td>&nbsp;</td>
      <td><a href=@referer@?order=first_names&order_direction=@first_names_order_direction@>
	First Name</a> @first_names_order_html@
      </td>	
      <td><a href=@referer@?order=last_name&order_direction=@last_name_order_direction@>
	Last Name</a> @last_name_order_html@
      </td>
      <td><a href=@referer@?order=email&order_direction=@email_order_direction@>
	Email</a> @email_order_html@
      </td>
      <td>Role</td>
      <td>Actions</td>
    </tr>
<multiple name="current_members">
<if @current_members.rownum@ odd>
    <tr class="odd">
</if>
<else>
    <tr class="even">
</else>
  <td>
   <if @admin_p@ eq 1>
	<input type=checkbox name=user_id value=@current_members.user_id@>
   </if>
 </td>
  <td><%=[acs_community_member_link -user_id  @current_members.user_id@ -label @current_members.first_names@] %></td>
  <td><%=[acs_community_member_link -user_id  @current_members.user_id@ -label @current_members.last_name@]%></td>
  <td>
    <if @read_private_data_p@ eq 1>
        <a href="mailto:@current_members.email@">
	@current_members.email@</a>	
    </if>
    <else>
	<if @my_user_id@ eq @current_members.user_id@>
    	    <a href="mailto:@current_members.email@">
	@current_members.email@</a>
	</if>
        <else>
           &nbsp;
        </else>
    </else>

   </td>
  <td><%=[template::util::nvl [dotlrn_community::get_role_pretty_name -community_id @community_id@ -rel_type @current_members.rel_type@] "Student"]%>
  </td>
  <td align=center>
  <if @admin_p@ eq 1>
     &nbsp; <a href="deregister?user_id=@current_members.user_id@&referer=@referer@"><img src=<%=[dotlrn::get_url]%>/graphics/drop.gif alt=\"Drop Membership\" border=0></a> | <a href="member-add-2?user_id=@current_members.user_id@&referer=@referer@"><img src=<%=[dotlrn::get_url]%>/graphics/admin.gif alt"User Admin Page" border=0></a>
  </if>
  <else> 
      <if @my_user_id@ eq @current_members.user_id@>
	  <a href="deregister?user_id=@current_members.user_id@&referer=@referer@"><img src=<%=[dotlrn::get_url]%>/graphics/drop.gif alt=\"Drop Membership\" border=0></a>
      </if>
      <else>
	   &nbsp;
      </else>
  </else>
</td>
</tr>
</multiple>
</table>

<p>

<if @admin_p@ eq 1>
<input type=hidden name=referer value="@referer@">
<input type=submit value="Drop selected members">
</form>
</if>

<ul>

<if @admin_p@ eq 1 and @subcomm_p@ eq 0>
  <br>

  </li>
</if>
<if @site_wide_admin_p@ eq 1>
<% set dotlrn_admin_url [dotlrn::get_admin_url] %>
  <br>
  <li>
    <a href="@dotlrn_admin_url@/community-members-add-to-community?source_community_id=@community_id@&referer=@referer@">
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
