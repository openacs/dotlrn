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

<master src="dotlrn-admin-master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

<if @term_id@ ne -1>
<ul>

  <li>
    #dotlrn.Name#
    @term_name@
  </li>

  <li>
    #dotlrn.Year#
    @term_year@
  </li>

  <li>
    #dotlrn.Start_date#
    @start_date@
  </li>

  <li>
    #dotlrn.End_date#
    @end_date@
  </li>

  <br>

  <li>
    <a href="term-edit?term_id=@term_id@&referer=@referer@">#dotlrn.Edit#</a> #dotlrn.term_properties#
  </li>

</ul>

<br>
</if>

<center>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr bgcolor="#eeeeee">
      <th align="left" width="50%">
<formtemplate id="department_form">
        <%= [parameter::get -localize -parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
</formtemplate>
      </th>
      <th align="left" width="50%">
<formtemplate id="term_form">
        #dotlrn.term#:&nbsp;<formwidget id="term_id">
</formtemplate>
      </th>
    </tr>
  </table>

  <br>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr>
      <th align="left" width="20%"><%= [parameter::get -localize -parameter departments_pretty_name] %></th>
      <th align="left" width="20%"><%= [parameter::get -localize -parameter classes_pretty_name] %></th>
<if @term_id@ eq -1>
      <th align="left" width="10%">#dotlrn.term#</th>
</if>
      <th align="left" width="25%"><%= [parameter::get -localize -parameter class_instances_pretty_name] %></th>
      <th align="center" width="10%">#dotlrn.members#</th>
      <th align="center">#dotlrn.actions#</th>
    </tr>

<if @classes:rowcount@ gt 0>

<multiple name="classes">

<if @classes.rownum@ odd>
    <tr bgcolor="#eeeeee">
</if>
<else>
    <tr bgcolor="#d9e4f9">
</else>
      <td align="left"><a href="department?department_key=@classes.department_key@">@classes.department_name@</a></td>
      <td align="left"><a href="class?class_key=@classes.class_key@">@classes.class_name@</a></td>
<if @term_id@ eq -1>
      <td align="left">@classes.term_name@ @classes.term_year@</td>
</if>
      <td align="left"><a href="@classes.url@">@classes.pretty_name@</a></td>
      <td align="center">@classes.n_members@</td>
      <td align="center">
        <nobr>
          <small>
            <a href="@classes.url@one-community-admin">#dotlrn.administer_link#</a>
          </small>
        </nobr>
      </td>
    </tr>

</multiple>

</if>
<else>
  <tr bgcolor="#eeeeee">
<if @term_id@ eq -1>
    <td align="left" colspan="6">
</if>
<else>
    <td align="left" colspan="5">
</else>
      <i>#dotlrn.no_class_instances#</i>
    </td>
  </tr>
</else>

  </table>

</center>
