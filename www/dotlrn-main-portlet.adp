<if @classes:rowcount@ gt 0>
  <%= [ad_parameter classes_pretty_plural] %>:
  <ul>
    <multiple name="classes">
      <li>
        <a href="@classes.url@">@classes.pretty_name@</a>
        <if @classes.admin_p@ eq t> 
          - <a class="note" href="@classes.url@one-community-admin">[&nbsp;admin&nbsp;]</a>
        </if>
      </li>
        <ul>
          <%=  [dotlrn_community::get_subcomm_chunk -community_id $classes(community_id)] %>
        </ul>
    </multiple>
  </ul>
</if>

<if @clubs:rowcount@ gt 0>
  <%= [ad_parameter clubs_pretty_plural] %>:
  <ul>
    <multiple name="clubs">
      <li>
        <a href="@clubs.url@">@clubs.pretty_name@</a>
        <if @clubs.admin_p@ eq t> 
          - <a class="note" href="@clubs.url@one-community-admin">[&nbsp;admin&nbsp;]</a>
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
