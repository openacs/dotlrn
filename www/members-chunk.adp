<h3>Users</h3>
<ul>
<multiple name="users">
  <li>
    @users.last_name@, @users.first_names@
    (<a href="mailto:@users.email@">@users.email@</a>),
    <i>@users.rel_type@</i>&nbsp;
    (<include src="deregister-link" url="community-deregister?user_id=@users.user_id@&referer=one-community-admin" label="remove">)
  </li>
</multiple>
  <p></p>
  <li>
    <form method="get" action="member-add">
      add a user: <input type="text" name="search_text"><input type="submit" value="search">
    </form>
  </li>
</ul>
