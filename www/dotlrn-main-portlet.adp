<if @classes:rowcount@ gt 0>
  <div class=larger><%= [ad_parameter classes_pretty_plural] %></div>
  <ul>
    <multiple name="classes">
      <li>
        <a href="@classes.url@">@classes.pretty_name@</a>
        <if @classes.admin_p@ eq t> 
          - <a class=note href="@classes.url@one-community-admin">[admin]</a>
        </if>
      </li>
        <ul>
          <%=  [dotlrn_community::get_subcomm_chunk -community_id $classes(community_id)] %>
        </ul>
    </multiple>
  </ul>
</if>

<if @clubs:rowcount@ gt 0>
  <div class=larger><%= [ad_parameter clubs_pretty_plural] %></div>
  <ul>
    <multiple name="clubs">
      <li>
        <a href="@clubs.url@">@clubs.pretty_name@</a>
        <if @clubs.admin_p@ eq t> 
          - <a class=note href="@clubs.url@one-community-admin">[admin]</a>
        </if>
      </li>
        <ul>
          <%= [dotlrn_community::get_subcomm_chunk -community_id $clubs(community_id)] %>
        </ul>
    </multiple>
  </ul>
</if>

<div class="note">
[
 <a href="/dotlrn/all-communities">Join/Drop a Class or Community Group</a>
]
</div>

