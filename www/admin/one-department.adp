<master src="master">
<property name="title">@pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<p>
  <a href="@external_url@">@external_url@</a>
</p>

<p>
  @description@
</p>

<p></p>

<if @classes:rowcount@ gt 0>
<b><% [ad_parameter classes_pretty_plural] %></b>
<ul>
<multiple name="classes">
  <li><a href="one-class?class_key=@class_key@">@classes.pretty_name@</a></li>
</multiple>
</ul>
</if>
