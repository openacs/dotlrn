<master src="dotlrn-admin-master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

[<small><a href="department-new?referer=departments">New <%= [ad_parameter departments_pretty_name] %></a></small>]

<p></p>

<if @departments:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left"><%= [ad_parameter departments_pretty_name] %> Name</th>
  </tr>
<multiple name="departments">
  <tr>
    <td><a href="department?department_key=@departments.department_key@">@departments.pretty_name@</a></td>
  </tr>
</multiple>
</table>
</if>

<if @departments:rowcount@ gt 10>
[<small><a href="department-new?referer=departments">New <%= [ad_parameter departments_pretty_name] %></a></small>]
</if>
