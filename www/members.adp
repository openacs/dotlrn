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

<master>
<property name="title">#dotlrn.Manage_Membership#</property>
<property name="link_all">1</property>

<include src="members-chunk-table" referer="members">

<if @spam_p@ true>
  <ul>
    <li>        <a href="spam-recipients?community_id=@community_id@&referer=@return_url@">#dotlrn.Email_Members#</a>
  </ul>
</if>
