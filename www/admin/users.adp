<master src="./master">
<property name="title">dotLRN Admin</property>
<property name="context_bar">@context_bar@</property>

<h3>dotLRN users</h3>
<ul>
<multiple name="users">
<li> @users.last_name@, @users.first_names@ (<a href=mailto:@users.email@>@users.email@</a>) - <i>@users.type@</i>
</multiple>
</ul>

<form method=get action=user-new>
Add a new dotLRN user: <input type=text name=search_text> <input type=submit value=search>
</form>


