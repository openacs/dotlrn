<master src="./master">
<property name="title">dotLRN Admin</property>
<property name="context_bar">@context_bar@</property>

<h3>dotLRN users</h3>
<table border=0 cellpadding=2 cellspacing=0 width=650>
<tr bgcolor=black>
<td>

<table border=0 cellpadding=2 cellspacing=0 width="100%">
<tr bgcolor=#aaaaaa>
<th align=left width="50%">User</th>
<th align=left>Type</th>
<th align=left>Access</th>
<th align=left>Read Private Data?</th>
</tr>

<% set i 0 %>
<multiple name="users">

<% 
if {$i == 0} {set bgcolor white} else {set bgcolor #cccccc}
set i [expr 1 - $i]
%>

<tr bgcolor=@bgcolor@>
<td><a href=user-edit?user_id=@users.user_id@>@users.last_name@, @users.first_names@</a> (<a href=mailto:@users.email@>@users.email@</a>)</td>
<td><i>@users.type@</i></td>
<td><if @users.limited_access_p@ eq t>Limited</if><else>Full</else></td>
<td><if @users.read_private_data_p@ eq t>YES</if><else>NO</else></td>
</tr>
</multiple>
</table>

</td></tr>
</table>

<p>

<form method=get action=user-new>
Add a new dotLRN user: <input type=text name=search_text> <input type=submit value=search>
</form>


