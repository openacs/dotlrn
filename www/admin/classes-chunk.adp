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

<center>

<if @can_create@>
  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="class-new?department_key=@department_key@&referer=@referer@">#dotlrn.new_class_1#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

  <br>
</if>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr bgcolor="#eeeeee">
      <th align="left" width="50%">
<formtemplate id="department_form">
        <%= [parameter::get -localize -parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
</formtemplate>
      </th>
    </tr>
  </table>

  <br>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">

    <tr>
      <th align="left" width="30%"><%= [parameter::get -localize -parameter departments_pretty_name] %></th>
      <th align="left">#dotlrn.class_name#</th>
      <th align="center" width="5%"><%= [parameter::get -localize -parameter class_instances_pretty_plural] %></th>
      <th align="center" width="10%">#dotlrn.Actions#</th>
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
      <td align="left"><a href="class?class_key=@classes.class_key@">@classes.pretty_name@</a></td>
      <td align="center">@classes.n_instances@</td>
      <td align="center">
<if @can_instantiate@>
        <nobr>
          <small>[
            <a href="class-instance-new?class_key=@classes.class_key@">#dotlrn.new_class_instance#</a>
          ]</small>
        </nobr>
</if>
    </td>
  </tr>

</multiple>
</if>
<else>
  <tr bgcolor="#eeeeee">
    <td align="left" colspan="4">
      <i>#dotlrn.no_classes#</i>
    </td>
  </tr>
</else>
  </table>

<if @can_create@ and @classes:rowcount@ gt 10>
  <br>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="class-new?department_key=@department_key@&referer=@referer@">#dotlrn.new_class_1#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>
</if>

</center>
