<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

%>

<table width="95%" cellpadding="0">
  <tr bgcolor="#000000">
    <td>
      <table width="100%">
        <tr bgcolor="#aaaaaa">
          <th align="left" width="50%">User</th>
          <th align="left">Access</th>
          <th align="left">Guest?</th>
          <th align="left">Site-wide Admin?</th>
        </tr>

<if @users:rowcount@ gt 0>
<multiple name="users">

<if @users.rownum@ odd>
        <tr bgcolor="#eeeeee">
</if>
<else>
        <tr bgcolor="#ffffff">
</else>
          <td>
            <if @type@ eq "deactivated">
                <a href="user?user_id=@users.user_id@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
            </if>
            <else>
              <if @type@ eq "pending">
                <a href="user?user_id=@users.user_id@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
              </if>
              <else>
                <a href="user?user_id=@users.user_id@">@users.last_name@, @users.first_names@</a> (<a href="mailto:@users.email@">@users.email@</a>)
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
</if>
<else>
        <tr bgcolor="#eeeeee">
          <td colspan="4"><i>No Users</i></td>
        </tr>
</else>

      </table>
    </td>
  </tr>
</table>
