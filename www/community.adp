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
<property name="context_bar">@context_bar@</property>
<property name="title">@pretty_name@</property>
<property name="portal_id">@portal_id@</property>

[
  <small>
    <include src="deregister-link">
    |
    <a href="configure">customize</a>
<if @admin_p@ eq 1>
    |
    <a href="one-community-admin">admin</a>
</if>
  </small>
]

@rendered_page@
