
<small>[<a href="/dotlrn/manage-memberships">Join/Drop a Class or Community Group</a>]</small>

<ul>

<if @classes:rowcount@ gt 0>
 <li><%= [ad_parameter classes_pretty_plural] %>:
  <ul>
    <multiple name="classes">
      <li>
        <a href="@classes.url@">@classes.pretty_name@</a>
        <if @classes.admin_p@ eq t> 
          <small>[<a href="@classes.url@one-community-admin">admin</a>]</small>
        </if>
      </li>
        <ul>
          <%=  [dotlrn_community::get_subcomm_chunk -community_id $classes(community_id)] %>
        </ul>
    </multiple>
  </ul>
</if>

<if @clubs:rowcount@ gt 0>
 <li><%= [ad_parameter clubs_pretty_plural] %>:
  <ul>
    <multiple name="clubs">
      <li>
        <a href="@clubs.url@">@clubs.pretty_name@</a>
        <if @clubs.admin_p@ eq t> 
            <small>[<a href="@clubs.url@one-community-admin">admin</a>]</small>
        </if>
      </li>
        <ul>
          <%= [dotlrn_community::get_subcomm_chunk -community_id $clubs(community_id)] %>
        </ul>
    </multiple>
  </ul>
</if>

</ul>
