<master src="master">
<property name="title">dotLRN New Community</property>

<form action="community-new-2" method=POST>
<table border=0>
<tr>
<td>Community Type</td>
<td><strong>@community_type@</strong></td>
</tr>
<tr>
<td>Name</td>
<td><INPUT TYPE=text name=pretty_name size=50></td>
</tr>
<tr>
<td>Year</td>
<td><INPUT TYPE=text name=year size=50></td>
</tr>
<tr>
<td>Term</td>
<td><INPUT TYPE=text name=term size=50></td>
</tr>
<tr>
<td valign=top>Description:</td>
<td><textarea name=description cols=50 rows=5 wrap=soft></textarea></td>
</tr>
</table>
<INPUT type=submit value="Create Class">
</form>
