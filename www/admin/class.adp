<a href="one-class?class_key=@class_key@">@pretty_name@</a>
<if @can_instantiate@ gt 0>
[
  <font size="-1">
    <a href="class-instance-new?class_key=@class_key@&referer=@referer@">New Instance</a>
  </font>
]
</if>
<else>
[
  <font size="-1" color="#aaaaaa">
    <i>New Instance</i>
  </font>
]
</else>

<if @instances:rowcount@ gt 0>
<blockquote>
<multiple name="instances">
  <include src="class-instance" class_instance_id="@instances.class_instance_id@" referer="@referer@"><br>
</multiple>
</blockquote>
</if>
