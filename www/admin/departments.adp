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

[<small>
  <a href="department-new?referer=@referer@">New <%= [parameter::get -parameter departments_pretty_name] %></a>
</small>]

<p></p>

<if @departments:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left"><%= [parameter::get -parameter departments_pretty_name] %> Name</th>
    <th align="left">Actions</th>
  </tr>
<multiple name="departments">
  <tr>
    <td><a href="department?department_key=@departments.department_key@">@departments.pretty_name@</a></td>
    <td>
<if @can_create@>
      [<small>
        <a href="class-new?department_key=@departments.department_key@&referer=department?department_key=@departments.department_key@">New <%= [parameter::get -parameter classes_pretty_name] %></a>
      </small>]
</if>
    </td>
  </tr>
</multiple>
</table>
</if>

<if @departments:rowcount@ gt 10>
[<small>
  <a href="department-new?referer=@referer@">New <%= [parameter::get -parameter departments_pretty_name] %></a>
</small>]
</if>
