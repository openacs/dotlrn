<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->

<master>
<property name="title">Manage Memberships</property>
<property name="context_bar">Manage Memberships</property>

<h3>Add/Drop Memberships</h3>

<if @n_member_classes@ gt 0 or @member_clubs:rowcount@ gt 0>
  <br><hr>

  <h4>Your Current Memberships</h4>

<if @n_member_classes@ gt 0>
    <br>

    <h4><%= [ad_parameter classes_pretty_plural] %></h4>

    <table bgcolor="#ececec" width="100%">
<formtemplate id="member_form">
        <th align="left" width="50%">
          <%= [ad_parameter departments_pretty_name] %>:&nbsp;<formwidget id="member_department_key">
        </th>
        <th align="left" width="50%">
          Term:&nbsp;<formwidget id="member_term_id">
        </th>
</formtemplate>
    </table>

<if @member_classes:rowcount@ gt 0>
    <table width="100%">
      <tr>
        <th align="left"><%= [ad_parameter classes_pretty_name] %></th>
        <th align="left">Term</th>
        <th align="left">Role</th>
        <th align="left">Actions</th>
      </tr>

<multiple name="member_classes">
      <tr>
        <td><a href="@member_classes.url@">@member_classes.pretty_name@</td>
        <td>@member_classes.term_name@ @member_classes.term_year@</td>
        <td>@member_classes.role@</td>
        <td>[&nbsp;<include src="deregister-link" url="@member_classes.url@deregister" referer=@referer@>&nbsp;]</td>
      </tr>
</multiple>
    </table>
</if>
<else>
  <small>No classes</small>
</else>

</if>

  <br>

  <h4><%= [ad_parameter clubs_pretty_plural] %></h4>

<if @member_clubs:rowcount@ gt 0>
    <table width="100%">
      <tr>
        <th align="left"><%= [ad_parameter clubs_pretty_name] %></th>
        <th align="left">Role</th>
        <th align="left">Actions</th>
      </tr>

<multiple name="member_clubs">
      <tr>
        <td><a href="@member_clubs.url@">@member_clubs.pretty_name@</td>
        <td>@member_clubs.role@</td>
        <td>[&nbsp;<include src="deregister-link" url="@member_clubs.url@deregister" referer=@referer@>&nbsp;]</td>
      </tr>
</multiple>
    </table>

</if>
<else>
  <p><small>No <%= [ad_parameter clubs_pretty_plural] %></small></p>
</else>

</if>

<if @n_non_member_classes@ gt 0 or @non_member_clubs:rowcount@ gt 0>
  <br><hr>

  <h4>Join A Group</h4>

<if @n_non_member_classes@ gt 0>
    <br>

    <h4><%= [ad_parameter classes_pretty_plural] %></h4>

    <table bgcolor="#ececec" width="100%">
<formtemplate id="non_member_form">
        <th align="left" width="50%">
          <%= [ad_parameter departments_pretty_name] %>:&nbsp;<formwidget id="non_member_department_key">
        </th>
        <th align="left" width="50%">
          Term:&nbsp;<formwidget id="non_member_term_id">
        </th>
</formtemplate>
    </table>

<if @non_member_classes:rowcount@ gt 0>
    <table width="100%">
      <tr>
        <th align="left"><%= [ad_parameter classes_pretty_name] %></th>
        <th align="left">Term</th>
        <th align="left">Actions</th>
      </tr>

<multiple name="non_member_classes">
      <tr>
        <td><a href="@non_member_classes.url@">@non_member_classes.pretty_name@</td>
        <td>@non_member_classes.term_name@ @non_member_classes.term_year@</td>
        <td>[&nbsp;<include src="register-link" url="@non_member_classes.url@register" referer=@referer@>&nbsp;]</td>
      </tr>
</multiple>
    </table>
</if>
<else>
  <small>No classes</small>
</else>

</if>

  <br>

  <h4><%= [ad_parameter clubs_pretty_plural] %></h4>
<if @non_member_clubs:rowcount@ gt 0>

    <table width="100%">
      <tr>
        <th align="left"><%= [ad_parameter clubs_pretty_name] %></th>
        <th align="left">Actions</th>
      </tr>

<multiple name="non_member_clubs">
      <tr>
        <td><a href="@non_member_clubs.url@">@non_member_clubs.pretty_name@</td>
        <td>[&nbsp;<include src="register-link" url="@non_member_clubs.url@register" referer=@referer@>&nbsp;]</td>
      </tr>
</multiple>
    </table>

</if>
<else>
  <p><small>No <%= [ad_parameter clubs_pretty_plural] %></small></p>
</else>

</if>
