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

<table border="0" width="100%">
  <tr>
    <td valign="top" width="50%">
<table class="element" border=0 cellpadding="0" cellspacing="0" width="100%">
<tr> 
  <td colspan="3" class="element-header-text">#dotlrn.lt_Help_and_Personal_Con#</td>
</tr>
<tr><td colspan="3" class="dark-line" height="0"><img src="/resources/dotlrn/spacer.gif"></td></tr>
<tr>
  <td class="light-line" width="1"><img src="/resources/dotlrn/spacer.gif" width="1"></td>
  <td class="element-text" width="100%">
<table cellspacing="0" cellpadding="0" class="element-content" width="100%">
	<tr><td>
<h3>#dotlrn.General_Site_Help#</h3> 
<ul>
  <li><a href="/global/HELP/indice.htm">#dotlrn.help#</a></li>
  <li>#dotlrn.Ask_a_question# <a href="mailto:@system_owner@">@system_owner@</a>
</ul>
<h3>#dotlrn.Personal_Options#</h3>
<ul>
  <li>
    <a href="@pvt_home@">@pvt_home_name@</a></li>

  <p><li><a href="configure">#dotlrn.Customize_Layout#</a></li>

<if @admin_p@>
  <p><li><a href="@admin_url@">@admin_pretty_name@</a></li>
</if>
</ul>
</td></tr></table>
 </td>
	  <td align="right" class="light-line" width="1"><img src="/resources/dotlrn/spacer.gif" width="1"></td>

</tr>
<tr><td colspan="3" class="light-line" width="1"><img src="/resources/dotlrn/spacer.gif"></td></tr>
</table>

    <td valign="top" width="50%">
<table class="element" border="0" cellpadding="0" cellspacing="0" width="100%">
<tr> 
  <td colspan="3" class="element-header-text">#dotlrn.lt_JoinDrop_Classes_or_C#</td>
</tr>
<tr><td colspan="3" class="dark-line" height="0"><img src="/resources/dotlrn/spacer.gif"></td></tr>
<tr>
  <td class="light-line" width="1"><img src="/resources/dotlrn/spacer.gif" width="1"></td>
  <td class="element-text" width="100%">
  <include src="dotlrn-main-portlet" show_buttons_p="1" title="Groups" referer="@dotlrn_url@/control-panel">
 </td>
	  <td align="right" class="light-line" width="1"><img src="/resources/dotlrn/spacer.gif" width="1"></td>

</tr>
<tr><td colspan="3" class="light-line" width="1"><img src="/resources/dotlrn/spacer.gif"></td></tr>
</table>
</table>
