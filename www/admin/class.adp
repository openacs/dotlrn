<a href="one-class?class_key=@class_key@">@pretty_name@</a>
[
  <font size="-1">
    <a href="class-instance-new?class_key=@class_key@&referer=classes">new instance</a>
  </font>
]

<if @instances:rowcount@ gt 0>
<blockquote>
<multiple name="instances">
  <include src="class-instance" class_instance_id="@instances.class_instance_id@"><br>
</multiple>
</blockquote>
</if>
