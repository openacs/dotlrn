<formtemplate id="user_search"></formtemplate>

<table border="0" cellpadding="2" cellspacing="0" width="95%">
  <tr bgcolor="black">
    <td>
      <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr bgcolor="#aaaaaa">
          <th align="left" width="50%">User</th>
          <th align="left">Access</th>
          <th align="left">Read Private Data?</th>
          <th align="left">Site-wide Admin?</th>
        </tr>

<% set i 0 %>

<multiple name="users">

<%
  if {!$i} {set bgcolor #ffffff} else {set bgcolor #cccccc}
  set i [expr 1 - $i]
%>

        <tr bgcolor="@bgcolor@">
          <td><a href="user-edit?user_id=@users.user_id@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)</td>
          <td align="center"><if @users.limited_access_p@ eq t>limited</if><else>full</else></td>
          <td align="center"><if @users.read_private_data_p@ eq t>yes</if><else>no</else></td>
          <td align="center">
            <if @user_id@ ne @users.user_id@>
              <if @users.site_wide_admin_p@ eq t>
                <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=revoke&referer=users">yes</a>
              </if>
              <else>
                <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=grant&referer=users">no</a>
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
