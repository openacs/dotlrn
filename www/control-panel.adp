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

<ul>
  <li><a href="@dotlrn_url@/help">#dotlrn.Help#</a></li>
  <li>
    <a href="/user/basic-info-update?return_url=@referer@">#dotlrn.lt_Edit_My_Personal_Info#</a>
    <br>
    <small>
      #dotlrn.lt_What_others_see_about#
      <%= [acs_community_member_link -user_id $user_id -label "[ad_url][acs_community_member_url -user_id $user_id]"] %>)
     </small>
  </li>
  <li><a href="/user/password-update?return_url=@referer@">#dotlrn.Change_My_Password#</a></li>
  <li><a href="applets/bboard/alerts">#dotlrn.lt_Edit_My_Bulletin_Boar#</a></li>
  <li><a href="configure">#dotlrn.Customize_Layout#</a></li>
<if @admin_p@>
  <li><a href="@admin_url@">@admin_pretty_name@</a></li>
</if>
</ul>

<blockquote>
  <include src="my-communities" title="Groups" referer="control_panel">
</blockquote>



