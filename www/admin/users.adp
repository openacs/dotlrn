<master src="master">
<property name="title">Users</property>
<property name="context_bar">@context_bar@</property>

[ <a href="../user-add?add_membership_p=f&referer=/dotlrn/admin/users"><font size="-1">Create A New User</font></a> ]

<p></p>

<form method="get" action="user-new">
  Add a new dotLRN user: <input type="text" name="search_text"><input type="submit" value="search">
</form>

<p></p>

<include src="users-chunk">
