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
<property name="title">Confirm Drop</property>

You are about to delete @num_users@ users.

<if @num_users@ lt 30>
	Note: This process is expected to take @num_seconds@ seconds.  
</if>
<else>
	Note: This process is expected to take @num_minutes@ minutes.  
</else>

<p>
<if @num_users@ lt @num_users_display_limit@>
   Do you really want to remove the following members?
</if>
<else>
   Do you really want to remove @num_users@ users?
</else>

<form method="post" action="deregister">
<input type=hidden name=referer value="@referer@">
@hidden_user_ids@
<ul>
<if @num_users@ lt 99>
 <multiple name="users_pending_drop">
 <li>@users_pending_drop.first_names@ @users_pending_drop.last_name@
 </multiple>
</if>
</ul>

<table>
  <tr>	

    <td halign=right>
	<input type=submit value="Yes">
	</form>
    </td>
    <td>
	<form method=post action=@referer@>
	<input type=submit value="No">
	</form>
    </td>
  </tr>
</table>

<p>
Note: The script will continue to run even if you 
close your browser.
