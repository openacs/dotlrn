<master src="master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

[ <a href="department-new?referer=departments">New <%= [ad_parameter departments_pretty_name] %></a> ]

<p></p>

<if @departments:rowcount@ gt 0>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
  <tr>
    <th align="left" width="30%"><%= [ad_parameter departments_pretty_name] %> Key</th>
    <th align="left"><%= [ad_parameter departments_pretty_name] %> Name</th>
  </tr>
<multiple name="departments">
  <tr>
    <td><a href="department?department_key=@departments.department_key@">@departments.department_key@</a></td>
    <td><a href="department?department_key=@departments.department_key@">@departments.pretty_name@</a></td>
  </tr>
</multiple>
</table>
</if>

<if @departments:rowcount@ gt 10>
[ <a href="department-new?referer=departments">New <%= [ad_parameter departments_pretty_name] %></a> ]
</if>
