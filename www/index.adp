<master src="master">
<property name="title">dotLRN</property>
<property name="portal_id">@portal_id@</property>

[
  <font size="-1">
    <a href="configure">customize</a>
<if @admin_p@ eq 1>
    |
    <a href="@admin_url@">dotLRN Admin</a>
</if>
  </font>
]

<p></p>

@rendered_page@
