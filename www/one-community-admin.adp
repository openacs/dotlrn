<master src="./master">
<property name="title">dotLRN Community Admin</property>
<property name="context_bar">@context_bar@</property>

<h3>Applets</h3>
<a href=community-applets>manage applets</a>

<p>

<h3>Users</h3>
<ul>
<multiple name="users">
<li> @users.last_name@, @users.first_names@ (<a href=mailto:@users.email@>@users.email@</a>), <i>@users.rel_type@</i>
</multiple>

<p>

<form method=get action=community-user-add><li> Add a user: <input type=text name=search_text> <input type=submit value=search></form>
</ul>

<h3>Portal Template</h3>
<a href=one-community-portal-template?portal_id=@portal_template_id@&return_url=one-community-admin?community_id=@community_id@>manage the portal template</a>
