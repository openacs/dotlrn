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
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

  <ul>
    <multiple name=templates>
      <li>@templates.name@ [<a href="@url@/portal-show.tcl?portal_id=@templates.portal_id@&referer=@referer@">view</a>|<a href="@url@/portal-config?portal_id=@templates.portal_id@&referer=@referer@">edit</a>]</li>
    </multiple>
  </ul>
</else>
