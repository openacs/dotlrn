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
      <li><a href="@classes.url@">@classes.pretty_name@</a></li>
      <%=  [dotlrn_community::get_subcomm_chunk -community_id $classes(community_id)] %>
      
    </multiple>
  </ul>
</if>

<if @clubs:rowcount@ gt 0>
  <%= [ad_parameter clubs_pretty_plural] %>
  <ul>
    <multiple name="clubs">
      <li>
        <a href="@clubs.url@">@clubs.pretty_name@</a>
        <if @clubs.admin_p@ eq t> - <a href="@clubs.url@one-community-admin">admin</a></if>
      </li>
      <%=  [dotlrn_community::get_subcomm_chunk -community_id $clubs(community_id)] %>
    </multiple>
  </ul>
</if>
