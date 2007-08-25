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

<master>
<property name="title">#dotlrn.Manage_Membership#</property>
<property name="link_all">1</property>
<property name="context">@context;noquote@</property>

<if @spam_p@ true>
<p>
  <a href="spam-recipients?community_id=@community_id@">#dotlrn.Email_Members#</a>
</p>
</if>

<if @admin_p@ eq 1 and @subcomm_p@ eq 0>
<form method="get" action="member-add">
   #dotlrn.Add_A_Member# <input type="text" name="search_text"><input
   type="submit" value="#dotlrn.search#">
   <input type="hidden" name="referer" value="@return_url@">
</form>
<a href="@add_member_url;noquote@" class="button">Create and add a member</a>
<p />
</if>


<listtemplate name="members"></listtemplate>

<if @admin_p@ eq 1>
  <h1>#dotlrn.Membership_Requests#</h1>
  <listtemplate name="pending_users"></listtemplate>
</if>

<if @admin_p@ eq 1 and @subcomm_p@ eq 1 and @n_parent_users@ gt 0>

  <hr>

  <h1>#dotlrn.Add_New_Members#</h1>

  <blockquote>
    <p>
      #dotlrn.lt_The_following_members#
    </p>

    <p>
      #dotlrn.lt_First_check_the_box_o#
    </p>
  </blockquote>

<formtemplate id="parent_users_form">
  <table width="75%" border="0">

    <tr>
      <td width="15%" align="center"><strong>#dotlrn.Dont_Add#</strong></td>
      <td width="15%" align="center"><strong>#dotlrn.Member#</strong></td>
      <td width="15%" align="center"><strong>#dotlrn.Administrator#</strong></td>
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
      <td width="15%" align="center">@formgroup.widget;noquote@</td>
</formgroup>
      <td>@this_last_name@, @this_first_names@ (@this_email@)</td>
    </tr>

<%
    }
%>

    <tr><td colspan="4">&nbsp;</td></tr>

    <tr>
      <td><input type="submit" value="#dotlrn.add_selected_members#"></td>
      <td colspan="3">&nbsp;</td>
    </tr>

  </table>
</formtemplate>

</if>
