<master src="master">
<property name="title">Users</property>
<property name="context_bar">@context_bar@</property>

[ 
  <a href="../user-add?add_membership_p=f&referer=/dotlrn/admin/users"><small>Create A New User</small></a> 
  |
  <a href="users-search"><small>Search Users</small></a>
  |
  <a href="users-bulk-upload"><small>Bulk Upload</small></a>
]

<p></p>

<form method="get" action="user-new">
  Add a new dotLRN user: <input type="text" name="search_text"><input type="submit" value="search">
</form>

<p></p>

<p>@control_bar@</p>

<if @n_users@ gt 2500>
  <include src="users-chunk-large" type=@type@ referer="/dotlrn/admin/users?type=@type@">
</if>
<else>
  <if @n_users@ gt 100>
    <include src="users-chunk-medium" type=@type@ referer="/dotlrn/admin/users?type=@type@">
  </if>
  <else>
    <include src="users-chunk-small" type=@type@ referer="/dotlrn/admin/users?type=@type@">
  </else>
</else>
