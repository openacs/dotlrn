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

<master>
<property name="title">#dotlrn.Manage_Memberships#</property>
<property name="context_bar">#dotlrn.Manage_Memberships#</property>

<h1>#dotlrn.AddDrop_Memberships#</h1>

<p>
  <small>
    <a href="#current_clubs" title="#dotlrn.goto_current_clubs#">#dotlrn.lt_Current_clubs_pretty_#</a>
    |
    <a href="#join_classes" title="#dotlrn.goto_join_class#">#dotlrn.lt_Join_a_class_instance#</a>
    |
    <a href="#join_clubs" title="#dotlrn.goto_join_clubs#">#dotlrn.lt_Join_a_clubs_pretty_n#</a>
  </small>
</p>

<if @n_member_classes@ gt 0 or @member_clubs:rowcount@ gt 0>
  <hr>

  <h2><a name="current">#dotlrn.lt_Your_Current_Membersh#</a></h2>

<if @n_member_classes@ gt 0>

<formtemplate id="member_form">
    <table cellpadding="0" cellspacing="0"  width="100%">
<tr class="table-header">

        <th align="left" width="50%">
          @departments_pretty_name@:&nbsp;<formwidget id="member_department_key">
        </th>
        <th align="left" width="50%">
          #dotlrn.Term#&nbsp;<formwidget id="member_term_id">
        </th>
</tr>
    </table>
</formtemplate>

<if @member_classes:rowcount@ gt 0>
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr class="list-header">
        <th id="class_name" align="left" width="55%">#dotlrn.class_name_header#</th>
        <th id="class_term" align="left" width="15%">#dotlrn.Term#</th>
        <th id="class_role" align="left" width="15%">#dotlrn.Role#</th>
        <th id="class_actions" align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="member_classes">

    <if @member_classes.rownum@ odd>
      <tr class="list-odd">
    </if>
    <else>
      <tr class="list-even">
    </else>
        <td headers="class_name"><a href="@member_classes.url@" title="#dotlrn.goto_member_classes_pretty_name#">@member_classes.pretty_name@</a></td>
        <td headers="class_term">@member_classes.term_name@ @member_classes.term_year@</td>
        <td headers="class_role">@member_classes.role@</td>
<if @member_classes.member_state@ eq "needs approval">
        <td headers="class_actions">[<small> #dotlrn.Pending_Approval# </small>]</td>
</if>
<else>
        <td headers="class_actions">
          <if @show_drop_button_p@ eq 1>
            <small><include src="deregister-link" url="@member_classes.url@deregister" referer=@referer@></small></td>
          </if>
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
      <tr class="list-header">
        <th id="club_name" align="left" colspan="2" width="70%">#dotlrn.clubs_name_header#</th>
        <th id="club_role" align="left" width="15%">#dotlrn.Role#</th>
        <th id="club_actions" align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="member_clubs">

    <if @member_clubs.rownum@ odd>
      <tr class="list-odd">
    </if>
    <else>
      <tr class="list-even">
    </else>
        <td headers="club_name" colspan="2"><a href="@member_clubs.url@" title="#dotlrn.goto_member_clubs_pretty_name#">@member_clubs.pretty_name@</a></td>
        <td headers="club_role">@member_clubs.role@</td>
<if @member_clubs.member_state@ eq "needs approval">
        <td headers="club_actions">[<small> #dotlrn.Pending_Approval# </small>]</td>
</if>
<else>
        <td headers="club_actions">
          <if @show_drop_button_p@ eq 1>
            <small><include src="deregister-link" url="@member_clubs.url@deregister" referer=@referer@></small></td>
          </if>
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

  <h2><a name="join_class">#dotlrn.Join_A_Group#</a></h2>

<if @n_non_member_classes@ gt 0>

<formtemplate id="non_member_form">
    <table cellpadding="0" cellspacing="0" width="100%">
<tr class="table-header">
        <th align="left" width="50%">
          @departments_pretty_name@:&nbsp;<formwidget id="non_member_department_key">
        </th>
        <th align="left" width="50%">
          #dotlrn.Term#&nbsp;<formwidget id="non_member_term_id">
        </th>
</tr>
    </table>
</formtemplate>

<if @non_member_classes:rowcount@ gt 0>
    <table celladding="0" cellspacing="0" width="100%">
      <tr class="list-header">
        <th id="non_class_name" align="left" width="25%">#dotlrn.class_name_header#</th>
	<th id="non_class_descrip" align="left" width="30%">#dotlrn.Description#</th>
        <th id="non_class_term" align="left" width="15%">#dotlrn.Term#</th>
        <th id="non_class_startdate" align="left" width="15%">#dotlrn.Start_date#</th>
        <th id="non_class_actions" align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="non_member_classes">

    <if @non_member_classes.rownum@ odd>
      <tr class="list-odd">
    </if>
    <else>
      <tr class="list-even">
    </else>
<if @non_member_classes.join_policy@ eq "open">
        <td headers="non_class_name">
	  <if @swa_p@ eq 1><a href="@non_member_classes.url@" title="#dotlrn.goto_non_member_classes#">@non_member_classes.pretty_name@</a></if>
	  <else>@non_member_classes.pretty_name@</else>
	</td>
	<td headers="non_class_descrip">@non_member_classes.description;noquote@</td>
        <td headers="non_class_term">@non_member_classes.term_name@ @non_member_classes.term_year@</td>
        <td headers="non_class_startdate">@non_member_classes.active_start_date@ - @non_member_classes.active_end_date@</td>
        <td headers="non_class_actions"><small><include src="register-link" community_id="@non_member_classes.community_id@" referer=@referer@></small></td>
</if>
<else>
        <td headers="non_class_name">@non_member_classes.pretty_name@</td>
	<td headers="non_class_descrip">@non_member_classes.description;noquote@</td>
        <td headers="non_class_term">@non_member_classes.term_name@ @non_member_classes.term_year@</td>
        <td headers="non_class_startdate">@non_member_classes.active_start_date@ - @non_member_classes.active_end_date@</td>
        <td headers="non_class_actions"><small><include src="register-link" community_id="@non_member_classes.community_id@" referer=@referer@ label="Request Membership" ></small></td>
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
<a name="join_club"></a>
    <table cellpadding="0" cellspacing="0" width="100%">
      <tr class="list-header">
        <th id="non_club_name" align="left" width="25%">#dotlrn.clubs_name_header#</th>
        <th id="non_club_descrip" align="left" width="45%">#dotlrn.Description#</th>
        <th id="non_club_startdate" align="left" width="15%">#dotlrn.Start_date#</th>
        <th id="non_club_actions" align="center" width="15%">#dotlrn.Actions#</th>
      </tr>

<multiple name="non_member_clubs">

    <if @non_member_clubs.rownum@ odd>
      <tr class="list-odd">
    </if>
    <else>
      <tr class="list-even">
    </else>
<if @non_member_clubs.join_policy@ eq "open">
        <td headers="non_club_name">
	  <if @swa_p@ eq 1>
	    <a href="@non_member_clubs.url@" title="#dotlrn.goto_non_member_clubs#">@non_member_clubs.pretty_name@</a>
	  </if>
	  <else>@non_member_clubs.pretty_name@</else>
	</td>
        <td headers="non_club_descrip">@non_member_clubs.description;noquote@</td>
        <td headers="non_club_startdate">@non_member_clubs.active_start_date@ - @non_member_clubs.active_end_date@</td>
        <td headers="non_club_actions"><small><include src="register-link" community_id="@non_member_clubs.community_id@" referer=@referer@></small></td>
</if>
<else>
        <td headers="non_club_name">@non_member_clubs.pretty_name@</td>
        <td headers="non_club_descrip">@non_member_clubs.description;noquote@</td>
        <td headers="non_club_startdate">@non_member_clubs.active_start_date@ - @non_member_clubs.active_end_date@</td>
        <td headers="non_club_actions"><small><include src="register-link" community_id="@non_member_clubs.community_id@"referer=@referer@  label="Request Membership"></small></td>
</else>
      </tr>
</multiple>
    </table>

</if>
<else>
  <p><small>#dotlrn.no_clubs#</small></p>
</else>

</if>


