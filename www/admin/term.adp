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
    <a href="term-edit?term_id=@term_id@&referer=@referer@">Edit</a> term
    properties.
  </li>

</ul>

<br>
</if>

<table bgcolor="#ececec" width="100%">
  <tr>
    <th align="left" width="50%">
<formtemplate id="department_form">
      <%= [ad_parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
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
    <th align="left" width="25%"><%= [ad_parameter departments_pretty_name] %></th>
    <th align="left" width="25%"><%= [ad_parameter classes_pretty_name] %></th>
<if @term_id@ eq -1>
    <th align="left" width="10%">Term</th>
</if>
    <th align="left" width="25%"><%= [ad_parameter class_instances_pretty_name] %></th>
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
    <td>[<small><a href="@classes.url@one-community-admin">admin</a></small>]</td>
  </tr>
</multiple>
</table>
</if>
