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
<property name="title">@pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<ul>

  <li>
    Description:
<if @description@ not nil>
    <pre>@description@</pre>
</if>
<else>
    &lt;none set up&gt;
</else>
  </li>

  <br>

  <li>
    <a href="class-edit?class_key=@class_key@&referer=@referer@">Edit</a> <%= [parameter::get -parameter classes_pretty_name] %> properties.
  </li>

</ul>

<br>

<center>

<if @can_instantiate@>
  <table cellpadding="5" width="95%">
    <tr>
      <td>
        <nobr>
          <small>[
            <a href="class-instance-new?class_key=@class_key@">New <%= [parameter::get -parameter class_instances_pretty_name] %></a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

  <br>
</if>
<else>
<include src="need-term-note">
</else>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr bgcolor="#eeeeee">
      <th align="left" width="50%">
  <formtemplate id="term_form">
        Term:&nbsp;<formwidget id="term_id">
  </formtemplate>
      </th>
    </tr>
  </table>

  <br>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr>
      <th align="left" width="15%">Term</th>
      <th align="left">
        <%= [parameter::get -parameter class_instances_pretty_name] %> Name
      </th>
      <th align="center" width="5%">Members</th>
      <th align="center" width="10%">Actions</th>
    </tr>

<if @class_instances:rowcount@ gt 0>

<multiple name="class_instances">

<if @class_instances.rownum@ odd>
    <tr bgcolor="#eeeeee">
</if>
<else>
    <tr bgcolor="#d9e4f9">
</else>
      <td><a href="term?term_id=@class_instances.term_id@">@class_instances.term_name@&nbsp;@class_instances.term_year@</a></td>
      <td><a href="@class_instances.url@">@class_instances.pretty_name@</a></td>
      <td align="center">@class_instances.n_members@</td>
      <td align="center">
        <nobr>
        <small>
          [ <a href="@class_instances.url@one-community-admin">Administer</a> ]
        </small>
        </nobr>
      </td>
    </tr>

</multiple>

</if>
<else>
    <tr bgcolor="#eeeeee">
      <td colspan="4">
        <i>No <%= [parameter::get -parameter class_instances_pretty_plural] %></i>
      </td>
    </tr>
</else>

  </table>

</center>
