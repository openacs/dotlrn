<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">@pretty_name@</property>
<property name="portal_id">@portal_id@</property>

[
  <font size="-1">
    <include src="deregister-link">
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
