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
<property name="title">@spam_name@</property>
<property name="context_bar">@context_bar@</property>


<h3>#dotlrn.Choose_members_to_receive#</h3>

<form method="post" action="spam">
<p>

Send to the following roles: <p>

@rel_types_html;noquote@
<input type=checkbox name=spam_all> #dotlrn.Send_to_all#
<p>

In addition, send to the following people (if you have not selected "Send to Everyone" above):<p>

<table  width="85%" class="table-display" cellpadding="5" cellspacing="0">
    <tr class="table-header">
      <td>&nbsp;</td>
      <td>#dotlrn.First_Name#</td>	
      <td>#dotlrn.Last_Name#</td>
      <td>#dotlrn.Email_1#</td>
    </tr>
<multiple name="current_members">
<if @current_members.rownum@ odd>
    <tr class="odd">
</if>
<else>
    <tr class="even">
</else>
  <td>
    <input type=checkbox name=recipients value=@current_members.user_id@>
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
</tr>
</multiple>
</table>

@exported_vars;noquote@
<center>
<input type=submit value="#dotlrn.Compose_bulk_message#">
</center>
</form>

<p>

