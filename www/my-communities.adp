<h3><if @title@ nil>My Communities</if><else>@title@</else></h3>

<ul>
<multiple name="communities">
  <li>
    <a href="@communities.url@">@communities.pretty_name@</a>
    - @communities.role@
<if @communities.admin_p@ eq 1>
    - [ <a href="@communities.url@spam?community_id=@communities.community_id@&referer=@referer@">Email Members</a> ]
</if>
    - [<include src="deregister-link" url="deregister?community_id=@communities.community_id@&referer=@referer@">]
  </li>
</multiple>
  <p></p>
  <li><a href="all-communities">Join A Group</a></li>
</ul>
