<master src="./master">
<property name="title">dotLRN Class Instance</property>

<h3>Applets</h3>
<a href=community-applets?community_id=@class_instance_id@>manage applets</a>

<p>

<h3>Users</h3>
<ul>
<multiple name="users">
<li> @users.last_name@, @users.first_names@ (<a href=mailto:@users.email@>@users.email@</a>), <i>@users.rel_type@</i>
</multiple>

<p>

<form method=get action=community-user-add><li> Add a user: <input type=hidden name=community_id value=@class_instance_id@><input type=text name=search_text> <input type=submit value=search></form>
</ul>

<h3>Portal Template</h3>
<a href=one-instance-portal-template?portal_id=@portal_template_id@&return_url=one-class-instance?class_instance_id=@class_instance_id@>manage the portal template</a>
