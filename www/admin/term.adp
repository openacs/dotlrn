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

<if @term_id@ ne -1>
<ul>

  <li>
    Name:
    @term_name@
  </li>

  <li>
    Year:
    @term_year@
  </li>

  <li>
    Start date:
    @start_date@
  </li>

  <li>
    End date:
    @end_date@
  </li>

  <br>

  <li>
    <a href="term-edit?term_id=@term_id@&referer=@referer@">Edit</a> term properties.
  </li>

</ul>

<br>
</if>

<table bgcolor="#eeeeee" width="100%">
  <tr>
    <th align="left" width="50%">
<formtemplate id="department_form">
      <%= [parameter::get -parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
</formtemplate>
    </th>
    <th align="left" width="50%">
<formtemplate id="term_form">
      Term:&nbsp;<formwidget id="term_id">
</formtemplate>
    </th>
  </tr>
</table>

<p></p>

<if @classes:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left" width="20%"><%= [parameter::get -parameter departments_pretty_name] %></th>
    <th align="left" width="20%"><%= [parameter::get -parameter classes_pretty_name] %></th>
<if @term_id@ eq -1>
    <th align="left" width="10%">Term</th>
</if>
    <th align="left" width="25%"><%= [parameter::get -parameter class_instances_pretty_name] %></th>
    <th align="left" width="10%">Members</th>
    <th align="left">Actions</th>
  </tr>
<multiple name="classes">
  <tr>
    <td><a href="department?department_key=@classes.department_key@">@classes.department_name@</a></td>
    <td><a href="class?class_key=@classes.class_key@">@classes.class_name@</a></td>
<if @term_id@ eq -1>
    <td>@classes.term_name@ @classes.term_year@</td>
</if>
    <td><a href="@classes.url@">@classes.pretty_name@</a></td>
    <td>@classes.n_members@</td>
    <td>[<small> <a href="@classes.url@one-community-admin">Administer</a> </small>]</td>
  </tr>
</multiple>
</table>
</if>
