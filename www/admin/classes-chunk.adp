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

<if @can_create@>
[<small><a href="class-new?department_key=@department_key@&referer=@referer@">New <%= [ad_parameter classes_pretty_name] %></a></small>]
</if>

<p></p>

<table bgcolor="#ececec" width="100%">
  <tr>
    <th align="left" width="50%">
<formtemplate id="department_form">
      <%= [dotlrn::parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
</formtemplate>
    </th>
  </tr>
</table>

<p></p>

<if @classes:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left" width="30%"><%= [dotlrn::parameter departments_pretty_name] %></th>
    <th align="left"><%= [dotlrn::parameter classes_pretty_name] %> Name</th>
  </tr>
<multiple name="classes">
  <tr>
    <td><a href="department?department_key=@classes.department_key@">@classes.department_name@</a></td>
    <td><a href="class?class_key=@classes.class_key@">@classes.pretty_name@</a></td>
  </tr>
</multiple>
</table>
</if>

<if @can_create@ and @classes:rowcount@ gt 10>
[<small><a
href="class-new?department_key=@department_key@&referer=@referer@">New <%= [dotlrn::parameter classes_pretty_name] %></a></small>]
</if>
