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

<if @n_communities@ gt 0>
  <h3><if @title@ nil>#dotlrn.Communities#</if><else>@title@</else></h3>

  <p>@filter_bar;noquote@</p>

<if @communities:rowcount@ gt 0>
<multiple name="communities">
  <table>
<group column="root_community_type">
    <tr>
      <td width="65%"><a href="@communities.url@">@communities.pretty_name@</a></td>
      <td>
<if @communities.member_p@ eq 0>
        (<include src="register-link" url="register?community_id=@communities.community_id@&referer=@referer@">)
</if>
<else>
        (<include src="deregister-link" url="deregister?community_id=@communities.community_id@&referer=@referer@">)
</else>
      </td>
      <td>
<if @communities.admin_p@ eq 1>
        (<a href="@communities.url@one-community-admin">#dotlrn.admin#</a>)
</if>
      </td>
    </tr>
</group>
  </table>

  <p></p>
</multiple>
</if>
</if>



