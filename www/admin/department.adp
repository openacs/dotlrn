<master src="dotlrn-admin-master">
<property name="title">@pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<ul>

  <li>
    External URL:
<if @external_url@ not nil>
    <a href="@external_url@">@external_url@</a>
</if>
<else>
    &lt;none set up&gt;
</else>
  </li>

  <li>
    Description:
<if @description@ not nil>
    @description@
</if>
<else>
    &lt;none set up&gt;
</else>
  </li>

  <br>

  <li>
    Click <a
    href="department-edit?department_key=@department_key@&referer=@referer@">here</a>
    to edit department properties.
  </li>

</ul>

<br>

<include src="classes-chunk" department_key="@department_key@">
