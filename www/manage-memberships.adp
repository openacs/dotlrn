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
<property name="title">#dotlrn.Manage_Memberships#</property>
<property name="context_bar">#dotlrn.Manage_Memberships#</property>

<h3>#dotlrn.AddDrop_Memberships#</h3>

<p>
  <small>
    <a href="#current_clubs">#dotlrn.lt_Current_clubs_pretty_#</a>
    |
    <a href="#join_classes">#dotlrn.lt_Join_a_class_instance#</a>
    |
    <a href="#join_clubs">#dotlrn.lt_Join_a_clubs_pretty_n#</a>
  </small>
</p>

<if @n_member_classes@ gt 0 or @member_clubs:rowcount@ gt 0>
  <hr>

  <h4><a name="current">#dotlrn.lt_Your_Current_Membersh#</a></h4>

<if @n_member_classes@ gt 0>

    <table cellpadding="0" cellspacing="0"  width="100%">
<tr class="table-header">

<formtemplate id="member_form">
        <th align="left" width="50%">
          <%= [parameter::get -localize -parameter departments_pretty_name] %>:&nbsp;<formwidget id="member_department_key">
        </th>
        <th align="left" width="50%">
          #dotlrn.Term#&nbsp;<formwidget id="member_term_id">
        </th>
</formtemplate>
</tr>
    </table>

<if @member_classes:rowcount@ gt 0>
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr class="table-title">
        <th align="left" width="55%">#dotlrn.class_name_header#</th>
        <th align="left" width="15%">#dotlrn.Term#</th>
        <th align="left" width="15%">#dotlrn.Role#</th>
        <th align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="member_classes">

    <if @member_classes.rownum@ odd>
      <tr class="odd">
    </if>
    <else>
      <tr class="even">
    </else>
        <td><a href="@member_classes.url@">@member_classes.pretty_name@</td>
        <td>@member_classes.term_name@ @member_classes.term_year@</td>
        <td>@member_classes.role@</td>
<if @member_classes.member_state@ eq "needs approval">
        <td>[<small> #dotlrn.Pending_Approval# </small>]</td>
</if>
<else>
        <td><small><include src="deregister-link" url="@member_classes.url@deregister" referer=@referer@></small></td>
</else>
      </tr>
</multiple>
    </table>
</if>
<else>
  <small>#dotlrn.No_classes#</small>
</else>

</if>

<if @member_clubs:rowcount@ gt 0>
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr class="table-title">
        <th align="left" colspan="2" width="70%">#dotlrn.clubs_name_header#</th>
        <th align="left" width="15%">#dotlrn.Role#</th>
        <th align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="member_clubs">

    <if @member_clubs.rownum@ odd>
      <tr class="odd">
    </if>
    <else>
      <tr class="even">
    </else>
        <td colspan="2"><a href="@member_clubs.url@">@member_clubs.pretty_name@</td>
        <td>@member_clubs.role@</td>
<if @member_clubs.member_state@ eq "needs approval">
        <td>[<small> #dotlrn.Pending_Approval# </small>]</td>
</if>
<else>
        <td><small><include src="deregister-link" url="@member_clubs.url@deregister" referer=@referer@></small></td>
</else>
      </tr>
</multiple>
    </table>
</if>
<else>
  <p><small>#dotlrn.no_clubs#</small></p>
</else>

</if>

<if @n_non_member_classes@ gt 0 or @non_member_clubs:rowcount@ gt 0>
<hr>

  <h4><a name="join_class">#dotlrn.Join_A_Group#</a></h4>

<if @n_non_member_classes@ gt 0>

    <table cellpadding="0" cellspacing="0" width="100%">
<tr class="table-header">
<formtemplate id="non_member_form">
        <th align="left" width="50%">
          <%= [parameter::get -localize -parameter departments_pretty_name] %>:&nbsp;<formwidget id="non_member_department_key">
        </th>
        <th align="left" width="50%">
          #dotlrn.Term#&nbsp;<formwidget id="non_member_term_id">
        </th>
</formtemplate>
</tr>
    </table>

<if @non_member_classes:rowcount@ gt 0>
    <table celladding="0" cellspacing="0" width="100%">
      <tr class="table-title">
        <th align="left" width="55%">#dotlrn.class_name_header#</th>
        <th align="left" width="15%">#dotlrn.Term#</th>
        <th align="left" width="15%">&nbsp;</th>
        <th align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="non_member_classes">

    <if @non_member_classes.rownum@ odd>
      <tr class="odd">
    </if>
    <else>
      <tr class="even">
    </else>
        <td><a href="@non_member_classes.url@">@non_member_classes.pretty_name@</td>
        <td>@non_member_classes.term_name@ @non_member_classes.term_year@</td>
        <td>&nbsp;</td>
<if @non_member_classes.join_policy@ eq "open">
        <td><small><include src="register-link" community_id="@non_member_classes.community_id@" referer=@referer@></small></td>
</if>
<else>
        <td><small><include src="register-link" community_id="@non_member_classes.community_id@" referer=@referer@ label="Request Membership" ></small></td>
</else>
      </tr>
</multiple>
    </table>
</if>
<else>
  <small>#dotlrn.No_classes#</small>
</else>

</if>

<if @non_member_clubs:rowcount@ gt 0>
<a name="join_club"><p></a>
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr class="table-title">
        <th align="left" width="55%">#dotlrn.clubs_name_header#</th>
        <th align="left" width="15%">&nbsp;</th>
        <th align="left" width="15%">&nbsp;</th>
        <th align="center">#dotlrn.Actions#</th>
      </tr>

<multiple name="non_member_clubs">

    <if @non_member_clubs.rownum@ odd>
      <tr class="odd">
    </if>
    <else>
      <tr class="even">
    </else>
        <td><a href="@non_member_clubs.url@">@non_member_clubs.pretty_name@</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
<if @non_member_clubs.join_policy@ eq "open">
        <td><small><include src="register-link" community_id="@non_member_clubs.community_id@" referer=@referer@></small></td>
</if>
<else>
        <td><small><include src="register-link" community_id="@non_member_clubs.community_id@"referer=@referer@  label="Request Membership"></small></td>
</else>
      </tr>
</multiple>
    </table>

</if>
<else>
  <p><small>#dotlrn.no_clubs#</small></p>
</else>

</if>
