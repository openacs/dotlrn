<h3>Members of <%= [dotlrn_community::get_community_name $community_id] %></h3>

<ul>

<multiple name="users">
  <li>
    <%= [acs_community_member_link -user_id $users(user_id) -label "$users(first_names) $users(last_name)"] %>
<if @read_private_data_p@ eq 1 or @user_id@ eq @users.user_id@>
    (<a href="mailto:@users.email@">@users.email@</a>)
</if>
    &nbsp;
    <i>@users.rel_type@</i>
<if @admin_p@ eq 1 or @user_id@ eq @users.user_id@>
    &nbsp;
    <small>[<include src="deregister-link" url="deregister?user_id=@users.user_id@&referer=@referer@" label="Drop Membership">]</small>
  </li>
</if>
</multiple>

<if @admin_p@ eq 1>
  <br>
  <li>
    <form method="get" action="member-add">
      Add A Member: <input type="text" name="search_text"><input type="submit" value="search">
      <input type="hidden" name="referer" value="@referer@">
    </form>
  </li>
</if>

<if @site_wide_admin_p@ eq 1>
  <br>
  <li>
    <a
    href="/dotlrn/admin/users-add-to-community?users=@user_list@&referer=@referer@">Add
    members to another community</a>
  </li>
</if>

</ul>
