<master src="master">
<property name="title">@pretty_name@ (@class_key@)</property>
<property name="context_bar">@context_bar@</property>

<p>
  @description@
</p>

<p></p>

<if @class_instances:rowcount@ gt 0>
<b>Instances</b>
<ul>
<multiple name="class_instances">
  <li><a href="@class_instances.url@one-community-admin">@class_instances.pretty_name@</a></li>
</multiple>
<if @can_instantiate@ gt 0>
  <p></p>
  <li><a href="class-instance-new?class_key=@class_key@">New Instance</a></li>
</if>
<else>
  <p>
  <include src="need-term-note">
  </p>
</else>
</ul>
</if>
