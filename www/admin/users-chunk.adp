<table width="95%">
  <tr bgcolor="black">
    <td>
      <table>
        <tr bgcolor="#aaaaaa">
          <th align="left" width="50%">User</th>
          <th align="left">Access</th>
          <th align="left">Guest?</th>
          <th align="left">Site-wide Admin?</th>
        </tr>

<% set i 0 %>

<multiple name="users">

<%
  if {!$i} {set bgcolor #ffffff} else {set bgcolor #cccccc}
  set i [expr 1 - $i]
%>

        <tr bgcolor="@bgcolor@">
          <td>
            <if @type@ eq "deactivated">
                <a href="/acs-admin/users/member-state-change?user_id=@users.user_id@&member_state=approved&return_url=@referer@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
            </if>
            <else>
              <if @type@ eq "pending">
                <a href="user-new-2?user_id=@users.user_id@&referer=@referer@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
              </if>
              <else>
                <a href="user-edit?user_id=@users.user_id@&referer=@referer@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
              </else>
            </else>
          </td>
          <td align="center">@users.access_level@</td>
          <td align="center"><if @users.read_private_data_p@ eq t>no</if><else>yes</else></td>
          <td align="center">
            <if @user_id@ ne @users.user_id@>
              <if @users.site_wide_admin_p@ eq t>
                <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=revoke&referer=@referer@">yes</a>
              </if>
              <else>
                <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=grant&referer=@referer@">no</a>
              </else>
            </if>
            <else>yes</else>
          </td>
        </tr>

</multiple>

      </table>
    </td>
  </tr>
</table>
