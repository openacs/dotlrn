<%

    #
    #  Copyright (C) 2001, 2002 MIT
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

<center>
<table bgcolor="#cccccc" cellpadding="5" cellspacing="3" width="95%">
  <tr>
    <th align="left" width="50%">#dotlrn.User#</th>
    <th align="left">#dotlrn.Access#</th>
    <th align="left">#dotlrn.Guest#</th>
    <th align="left">#dotlrn.Site-wide_Admin#</th>
  </tr>

<if @users:rowcount@ gt 0>
<multiple name="users">

<if @users.rownum@ odd>
  <tr bgcolor="#eeeeee">
</if>
<else>
  <tr bgcolor="#d9e4f9">
</else>
    <td align="left">
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
    <td align="center"><if @users.read_private_data_p@ eq t>#dotlrn.no#</if><else>#dotlrn.yes#</else></td>
    <td align="center">
  <if @user_id@ ne @users.user_id@>
    <if @users.site_wide_admin_p@ eq t>
      <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=revoke&referer=@referer@">#dotlrn.yes#</a>
    </if>
    <else>
      <a href="site-wide-admin-toggle?user_id=@users.user_id@&value=grant&referer=@referer@">#dotlrn.no#</a>
    </else>
  </if>
      <else>#dotlrn.yes#</else>
    </td>
  </tr>

</multiple>
</if>
<else>
  <tr bgcolor="#eeeeee">
    <td align="left" colspan="4"><i>#dotlrn.No_Users#</i></td>
  </tr>
</else>

</table>
</center>



