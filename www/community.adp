<master src="dotlrn-master">
<property name="context_bar">@context_bar@</property>
<property name="title">@pretty_name@</property>
<property name="portal_id">@portal_id@</property>

[
  <small>
    <include src="deregister-link">
    |
    <a href="configure">customize</a>
<if @admin_p@ eq 1>
    |
    <a href="one-community-admin">admin</a>
</if>
  </small>
]

@rendered_page@
