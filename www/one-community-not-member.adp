<master>
<property name="context_bar">@context_bar@</property>
<property name="pretext">@pretext@</property>
<property name="portal_id">@portal_id@</property>
<property name="show_control_panel">@admin_p@</property>

<if @admin_p@ eq 0>
  <property name="no_navbar_p">1</property>
</if>

@rendered_page@
