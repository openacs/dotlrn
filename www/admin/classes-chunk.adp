[ <a href="class-new?department_key=@department_key@&referer=@referer@">New <%= [ad_parameter classes_pretty_name] %></a> ]

<p>
<include src="need-term-note">
</p>

@filter_bar@

<p></p>

<if @classes:rowcount@ gt 0>
<multiple name="classes">
<include src="class" class_key="@classes.class_key@" pretty_name="@classes.pretty_name@" referer="@referer@">
<p></p>
</multiple>
</if>

<if @classes:rowcount@ gt 10>
[ <a href="class-new?department_key=@department_key@&referer=@referer@">New <%= [ad_parameter classes_pretty_name] %></a> ]
</if>
