[
<font size="-1">
  <a href="/dotlrn/all-communities">Join/Drop a Class or Community Group</a>
</font>
]

<p></p>

<if @classes:rowcount@ gt 0>
  <%= [ad_parameter classes_pretty_plural] %>
  <ul>
    <multiple name="classes">
      <li><a href="@classes.url@">@classes.pretty_name@</a>
      <ul></ul>
      </li>
      
    </multiple>
  </ul>
</if>

<if @clubs:rowcount@ gt 0>
  <%= [ad_parameter clubs_pretty_plural] %>
  <ul>
    <multiple name="clubs">
      <li><a href="@clubs.url@">@clubs.pretty_name@</a></li>
    </multiple>
  </ul>
</if>
