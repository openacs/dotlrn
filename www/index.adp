<master src="master">
<property name="title">dotLRN</property>

<if @classes:rowcount@ eq 0>
<i>There are no classes available.</i><p>
</if>

<else>
<ul>
<multiple name=classes>
<li><a href=<%= [dotlrn_community::get_url -package_id @classes.package_id@] %>>@classes.pretty_name@</a>
</multiple>
</ul>
</else>

<p>
<ul>
<li> <a href=class-new>New Class</a>
</ul>
