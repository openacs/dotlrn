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

<master src="dotlrn-master">
<property name="title">Add A Member</property>
<property name="context_bar">@context_bar@</property>

The results of your search are:
<ul>
<multiple name="users">
  <li><a href="member-add-2?user_id=@users.user_id@&referer=@referer@">@users.last_name@, @users.first_names@ (@users.email@)</a></li>
</multiple>
</ul>
