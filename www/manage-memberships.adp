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

<master src="dotlrn-master">
<property name="title">Manage Memberships</property>
<property name="context_bar">Manage Memberships</property>

<h3>Add/Drop Memberships</h3>

<p>
  <small>
    <a href="#current_clubs">Current <%= [parameter::get -parameter clubs_pretty_plural] %></a>
    |
    <a href="#join_classes">Join a <%= [parameter::get -parameter class_instances_pretty_name] %></a>
    |
    <a href="#join_clubs">Join a <%= [parameter::get -parameter clubs_pretty_name] %></a>
  </small>
</p>

<if @n_member_classes@ gt 0 or @member_clubs:rowcount@ gt 0>
  <hr>

  <h4><a name="current">Your Current Memberships</a></h4>

<if @n_member_classes@ gt 0>

    <h4><a name="current_classes"><%= [parameter::get -parameter class_instances_pretty_plural] %></a></h4>

    <table bgcolor="#eeeeee" width="100%">
<formtemplate id="member_form">
        <th align="left" width="50%">
          <%= [parameter::get -parameter departments_pretty_name] %>:&nbsp;<formwidget id="member_department_key">
        </th>
        <th align="left" width="50%">
          Term:&nbsp;<formwidget id="member_term_id">
        </th>
</formtemplate>
    </table>

<if @member_classes:rowcount@ gt 0>
    <table width="100%">
      <tr>
        <th align="left" width="55%"><%= [parameter::get -parameter class_instances_pretty_name] %> Name</th>
        <th align="left" width="15%">Term</th>
        <th align="left" width="15%">Role</th>
        <th align="left" width="15%">Actions</th>
      </tr>

<multiple name="member_classes">

    <if @member_classes.rownum@ odd>
      <tr bgcolor="#eeeeee">
    </if>
    <else>
      <tr bgcolor="#ffffff">
    </else>
        <td><a href="@member_classes.url@">@member_classes.pretty_name@</td>
        <td>@member_classes.term_name@ @member_classes.term_year@</td>
        <td>@member_classes.role@</td>
<if @member_classes.member_state@ eq "needs approval">
        <td>[<small> Pending Approval </small>]</td>
</if>
<else>
        <td>[<small><include src="deregister-link" url="@member_classes.url@deregister" referer=@referer@></small>]</td>
</else>
      </tr>
</multiple>
    </table>
</if>
<else>
  <small>No classes</small>
</else>

</if>

  <h4><a name="current_clubs"><%= [parameter::get -parameter clubs_pretty_plural] %></a></h4>

<if @member_clubs:rowcount@ gt 0>
    <table width="100%">
      <tr>
        <th align="left" colspan="2" width="70%"><%= [parameter::get -parameter clubs_pretty_name] %> Name</th>
        <th align="left" width="15%">Role</th>
        <th align="left" width="15%">Actions</th>
      </tr>

<multiple name="member_clubs">

    <if @member_clubs.rownum@ odd>
      <tr bgcolor="#eeeeee">
    </if>
    <else>
      <tr bgcolor="#ffffff">
    </else>
        <td colspan="2"><a href="@member_clubs.url@">@member_clubs.pretty_name@</td>
        <td>@member_clubs.role@</td>
<if @member_clubs.member_state@ eq "needs approval">
        <td>[<small> Pending Approval </small>]</td>
</if>
<else>
        <td>[<small><include src="deregister-link" url="@member_clubs.url@deregister" referer=@referer@></small>]</td>
</else>
      </tr>
</multiple>
    </table>
</if>
<else>
  <p><small>No <%= [parameter::get -parameter clubs_pretty_plural] %></small></p>
</else>

</if>

<if @n_non_member_classes@ gt 0 or @non_member_clubs:rowcount@ gt 0>
  <hr>

  <h4><a name="join">Join A Group</a></h4>

<if @n_non_member_classes@ gt 0>

    <h4><a name="join_classes"><%= [parameter::get -parameter class_instances_pretty_plural] %></a></h4>

    <table bgcolor="#eeeeee" width="100%">
<formtemplate id="non_member_form">
        <th align="left" width="50%">
          <%= [parameter::get -parameter departments_pretty_name] %>:&nbsp;<formwidget id="non_member_department_key">
        </th>
        <th align="left" width="50%">
          Term:&nbsp;<formwidget id="non_member_term_id">
        </th>
</formtemplate>
    </table>

<if @non_member_classes:rowcount@ gt 0>
    <table width="100%">
      <tr>
        <th align="left" width="55%"><%= [parameter::get -parameter class_instances_pretty_name] %> Name</th>
        <th align="left" width="15%">Term</th>
        <th align="left" width="15%">&nbsp;</th>
        <th align="left" width="15%">Actions</th>
      </tr>

<multiple name="non_member_classes">

    <if @non_member_classes.rownum@ odd>
      <tr bgcolor="#eeeeee">
    </if>
    <else>
      <tr bgcolor="#ffffff">
    </else>
        <td><a href="@non_member_classes.url@">@non_member_classes.pretty_name@</td>
        <td>@non_member_classes.term_name@ @non_member_classes.term_year@</td>
        <td>&nbsp;</td>
<if @non_member_classes.join_policy@ eq "open">
        <td>[<small><include src="register-link" community_id="@non_member_classes.community_id@" referer=@referer@></small>]</td>
</if>
<else>
        <td>[<small><include src="register-link" community_id="@non_member_classes.community_id@" referer=@referer@ label="Request Membership" ></small>]</td>
</else>
      </tr>
</multiple>
    </table>
</if>
<else>
  <small>No classes</small>
</else>

</if>

  <h4><a name="join_clubs"><%= [parameter::get -parameter clubs_pretty_plural] %></a></h4>
<if @non_member_clubs:rowcount@ gt 0>

    <table width="100%">
      <tr>
        <th align="left" width="55%"><%= [parameter::get -parameter clubs_pretty_name] %> Name</th>
        <th align="left" width="15%">&nbsp;</th>
        <th align="left" width="15%">&nbsp;</th>
        <th align="left">Actions</th>
      </tr>

<multiple name="non_member_clubs">

    <if @non_member_clubs.rownum@ odd>
      <tr bgcolor="#eeeeee">
    </if>
    <else>
      <tr bgcolor="#ffffff">
    </else>
        <td><a href="@non_member_clubs.url@">@non_member_clubs.pretty_name@</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
<if @non_member_clubs.join_policy@ eq "open">
        <td>[<small><include src="register-link" community_id="@non_member_clubs.community_id@" referer=@referer@></small>]</td>
</if>
<else>
        <td>[<small><include src="register-link" community_id="@non_member_clubs.community_id@"referer=@referer@  label="Request Membership"></small>]</td>
</else>
      </tr>
</multiple>
    </table>

</if>
<else>
  <p><small>No <%= [parameter::get -parameter clubs_pretty_plural] %></small></p>
</else>

</if>
