<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">@pretty_name@</property>

[
  <font size="-1">
    <include src="deregister">
    |
    <a href="configure">customize</a>
<if @admin_p@ eq 1>
    |
    <a href="one-community-admin">admin</a>
</if>
  </font>
]

<p></p>

@rendered_page@
