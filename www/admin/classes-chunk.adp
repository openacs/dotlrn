<if @can_create@ gt 0>
[ <a href="class-new?department_key=@department_key@&referer=@referer@">New <%= [ad_parameter classes_pretty_name] %></a> ]
</if>

<p></p>

<table bgcolor="#ececec" border="0" cellspacing="0" cellpadding="3" width="100%">
  <tr>
    <th align="left" width="50%">
<formtemplate id="department_form">
      <%= [ad_parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
</formtemplate>
    </th>
  </tr>
</table>

<p></p>

<if @classes:rowcount@ gt 0>
<table border="0" cellspacing="0" cellpadding="3" width="100%">
  <tr>
    <th align="left" width="30%"><%= [ad_parameter departments_pretty_name] %></th>
    <th align="left" width="10%"><%= [ad_parameter classes_pretty_name] %> Key</th>
    <th align="left"><%= [ad_parameter classes_pretty_name] %> Name</th>
  </tr>
<multiple name="classes">
  <tr>
    <td><a href="one-department?department_key=@classes.department_key@">@classes.department_name@</a></td>
    <td><a href="one-class?class_key=@classes.class_key@">@classes.class_key@</a></td>
    <td><a href="one-class?class_key=@classes.class_key@">@classes.pretty_name@</a></td>
  </tr>
</multiple>
</table>
</if>

<if @can_create@ gt 0 and @classes:rowcount@ gt 10>
[ <a href="class-new?department_key=@department_key@&referer=@referer@">New <%= [ad_parameter classes_pretty_name] %></a> ]
</if>
