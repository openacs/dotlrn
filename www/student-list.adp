<master src="master">
<property name="title">@pretty_name@ - Student List</property>

<ul>
<multiple name=students>
<li> @students.last_name@, @students.first_names@ (<a href=mailto:@students.email@>@students.email@</a>), <i>@students.role@</i>
</multiple>
</ul>
