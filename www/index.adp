<master src="master">
<property name="title">dotLRN</property>

<if @admin_p@ eq 1>
  Visit <a href=@admin_url@>dotLRN Administration</a>.<br>
</if>

<a href=configure>Configure</a> this page.

<p>

@rendered_page@
