<master src="master">
<property name="title">dotLRN Classes</property>
<property name="context_bar">@context_bar@</property>

[ <a href="class-new">new class</a> ]

<p>
<include src="need-term-note">
</p>

<if @classes:rowcount@ gt 0>
<multiple name="classes">
<include src="class" class_key="@classes.class_key@" pretty_name="@classes.pretty_name@">
<p></p>
</multiple>
</if>

<if @classes:rowcount@ gt 10>
[ <a href="class-new">new class</a> ]
</if>
