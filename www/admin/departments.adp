<master src="master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

[ <a href="department-new?referer=departments">New <%= [ad_parameter departments_pretty_name] %></a> ]

<p></p>

<if @departments:rowcount@ gt 0>
<ul>
<multiple name="departments">
  <li><include src="department" department_key="@departments.department_key@" pretty_name="@departments.pretty_name@"></li>
  <p></p>
</multiple>
</ul>
</if>

<if @departments:rowcount@ gt 10>
[ <a href="department-new?referer=departments">New <%= [ad_parameter departments_pretty_name] %></a> ]
</if>
