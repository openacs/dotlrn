<master src="./master">
<property name="title">dotLRN Class Instance</property>

<h3>Users</h3>
<ul>
<multiple name="users">
<li> @users.last_name@, @users.first_names@ (<a href=mailto:@users.email@>@users.email@</a>), <i>@users.rel_type@</i>
</multiple>

<p>

<form method=get action=community-user-add><li> Add a user: <input type=hidden name=community_id value=@class_instance_id@><input type=hidden name=community_type value=dotlrn_class><input type=text name=search_text> <input type=submit value=search></form>
</ul>
