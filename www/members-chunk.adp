<h3>Members</h3>
<ul>
<multiple name="users">
  <li>
    @users.last_name@, @users.first_names@
    (<a href="mailto:@users.email@">@users.email@</a>),
    <i>@users.rel_type@</i>&nbsp;
    (<include src="deregister-link" url="deregister?user_id=@users.user_id@&referer=@referer@" label="remove">)
  </li>
</multiple>
  <p></p>
  <li>
    <form method="get" action="member-add">
      Add A Member: <input type="text" name="search_text"><input type="submit" value="search">
      <input type="hidden" name="referer" value="@referer@">
    </form>
  </li>
</ul>
