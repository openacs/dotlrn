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

<master src="dotlrn-admin-master">
<property name="title">dotLRN Admin</property>
<property name="context_bar">@context_bar@</property>

<h3>Add a Professor</h3>

<form method="get" action="add-instructor-2">
  <input type="hidden" name="referer" value="@referer@"></input>
  <input type="hidden" name="community_id" value="@community_id@"></input>
  Add a Professor: <input type="text" name="search_text"><input type="submit" value="search"></input>
</form>
