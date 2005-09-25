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
<property name="title">@title@</property>
<property name="link_control_panel">0</property>

<% set dotlrn_url [dotlrn::get_url] %>

<table>
	<tr><td>
<div class="portlet-wrapper">
<div class="portlet-title">
	<span><h2>#dotlrn.General_Site_Help#</h2></span>
</div>
<div class="portlet">
<ul>
  <li><a href="@dotlrn_url@/help">#dotlrn.help#</a></li>
  <li>#dotlrn.Ask_a_question# <a href="mailto:@system_owner@">@system_owner@</a></li>
</ul>
</div></div>
<div class="portlet-wrapper">
<div class="portlet-title">
        <span><h2>#dotlrn.Personal_Options#</h2></span>
</div>
<div class="portlet">
<ul>
  <li>
    <a href="@pvt_home@">#dotlrn.pvt_home_name#</a></li>

  <p><li><a href="configure">#dotlrn.Customize_Layout#</a></li>

<if @admin_p@>
  <p><li><a href="@admin_url@">@admin_pretty_name@</a> (<a href="@cockpit_url@">#dotlrn.Cockpit#</a>)</li>
</if>
</ul>

</div>
</div>

    <td valign="top" width="50%">
<div class="portlet-wrapper">
<div class="portlet-title">
  <span><h2>#dotlrn.lt_JoinDrop_Classes_or_C#</h2></span>
</div>
<div class="portlet">
  <include src="dotlrn-main-portlet" show_buttons_p="1" show_archived_p=0 title="Groups" referer="@dotlrn_url@/control-panel">

</div>
</div>
</table>
