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

<master src="dotlrn-master">
<property name="title">@title@</property>
<property name="link_control_panel">0</property>

<% set dotlrn_url [dotlrn::get_url] %>

<table border="0" width="100%">
  <tr>
    <td valign="top" width="50%">
<table class="element" border=0 cellpadding="0" cellspacing="0" width="100%">
<tr> 
  <td colspan=3 class="element-header-text">Help and Personal Configuration</td>
</tr>
<tr><td colspan=3 class="dark-line" height="0"><img src="/graphics/spacer.gif"></td></tr>
<tr>
  <td class="light-line" width="1"><img src="/graphics/spacer.gif" width="1"></td>
  <td class="element-text" width="100%">
<table cellspacing="0" cellpadding="0" class="element-content" width="100%">
	<tr><td>
<h3>General Site Help</h3> 
<ul>
  <li><a href="@dotlrn_url@/help">Help</a></li>
  <li>Ask a question <a href=mailto:@system_owner@>@system_owner@</a>
</ul>
<h3>Personal Options</h3>
<ul>
  <li>
    <a href="/user/basic-info-update?return_url=@referer@">Edit My Personal Information</a>
    <li>
      What others see about me:
      <%= [acs_community_member_link -user_id $user_id -label "[ad_url][acs_community_member_url -user_id $user_id]"] %>

  </li>
  <li><a href="/user/password-update?return_url=@referer@">Change My Password</a></li>
  <li><a href="/notifications/manage">Edit My Notifications</a></li>
  <li><a href="configure">Customize My Portal Layout</a></li>

<if @admin_p@>
  <li><a href="@admin_url@">@admin_pretty_name@</a></li>
</if>
</ul>
</td></tr></table>
 </td>
	  <td align="right" class="light-line" width="1"><img src="/graphics/spacer.gif" width="1"></td>

</tr>
<tr><td colspan=3 class="light-line" width="1"><img src="/graphics/spacer.gif"></td></tr>
</table>

    <td valign="top" width="50%">
<table class="element" border=0 cellpadding="0" cellspacing="0" width="100%">
<tr> 
  <td colspan=3 class="element-header-text">Join/Drop Classes or Communities</td>
</tr>
<tr><td colspan=3 class="dark-line" height="0"><img src="/graphics/spacer.gif"></td></tr>
<tr>
  <td class="light-line" width="1"><img src="/graphics/spacer.gif" width="1"></td>
  <td class="element-text" width="100%">
  <include src="dotlrn-main-portlet" show_buttons_p=1 title="Groups" referer="@dotlrn_url@/control-panel">
 </td>
	  <td align="right" class="light-line" width="1"><img src="/graphics/spacer.gif" width="1"></td>

</tr>
<tr><td colspan=3 class="light-line" width="1"><img src="/graphics/spacer.gif"></td></tr>
</table>
</table>

