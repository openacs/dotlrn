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

<h3><if @title@ nil>My Communities</if><else>@title@</else></h3>

<ul>
<multiple name="communities">
  <li>
    <a href="@communities.url@">@communities.pretty_name@</a>
    - @communities.role@
<if @communities.admin_p@ eq 1>
    - [ <a href="@communities.url@one-community-admin">admin</a> ]
    - [ <a href="@communities.url@spam?community_id=@communities.community_id@&referer=@referer@">Email Members</a> ]
</if>
    - [<include src="deregister-link" url="deregister?community_id=@communities.community_id@&referer=@referer@">]
  </li>
</multiple>
<if @user_can_browse_p@ eq 1>
  <p></p>
  <li><a href="manage-memberships">Join A Group</a></li>
</if>
</ul>
