<master src="master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

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
    <th align="left" width="30%"><%= [ad_parameter departments_pretty_name] %></th>
    <th align="left" width="30%"><%= [ad_parameter classes_pretty_name] %></th>
    <th align="left" width="30%"><%= [ad_parameter class_instances_pretty_name] %></th>
    <th align="left">Actions</th>
  </tr>
<multiple name="classes">
  <tr>
    <td><a href="department?department_key=@classes.department_key@">@classes.department_name@</a></td>
    <td><a href="class?class_key=@classes.class_key@">@classes.class_name@</a></td>
    <td><a href="@classes.url@">@classes.pretty_name@</a></td>
    <td>[<small><a href="@classes.url@one-community-admin">admin</a></small>]</td>
  </tr>
</multiple>
</table>
</if>
