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
<if @admin_p@ eq 1 and @subcomm_p@ eq 0>
<form method="get" action="member-add">
   #dotlrn.Add_A_Member# <input type="text" name="search_text"><input
   type="submit" value="#dotlrn.search#">
   <input type="hidden" name="referer" value="@referer@">
</form>
</if>


<listtemplate name="members"></listtemplate>

<if @admin_p@ eq 1 and @pending_users:rowcount@ gt 0>

<h3>#dotlrn.Membership_Requests#</h3>

<ul>
<multiple name="pending_users">
  <li>
    <%= [acs_community_member_link -user_id $pending_users(user_id) -label "$pending_users(first_names) $pending_users(last_name)"] %>
    (<a href="mailto:@pending_users.email@">@pending_users.email@</a>)
    &nbsp;
    <i>@pending_users.role@</i>
    &nbsp;
    [<small>
      <include src="approve-link"
      url="approve?user_id=@pending_users.user_id@&referer=@referer@">
      |
      <include src="reject-link"
      url="reject?user_id=@pending_users.user_id@&referer=@referer@">
    </small>]
  </li>
</multiple>
</ul>

</if>

<if @admin_p@ eq 1 and @subcomm_p@ eq 1 and @n_parent_users@ gt 0>

  <hr>

  <h3>#dotlrn.Add_New_Members#</h3>

  <blockquote>
    <p>
      #dotlrn.lt_The_following_members#
    </p>

    <p>
      #dotlrn.lt_First_check_the_box_o#
    </p>
  </blockquote>

<formtemplate id="parent_users_form">
</formtemplate>

</if>
