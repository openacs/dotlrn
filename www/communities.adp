<if @communities:rowcount@ gt 0>
  <h3><if @title@ nil>Communities</if><else>@title@</else></h3>
  <table cellpadding="5" cellspacing="5">
<multiple name="communities">
    <tr>
      <td><a href="@communities.url@">@communities.pretty_name@</a></td>
      <td> 
<if @communities.member_p@ eq "f">
        (<include src="register" url="community-register?community_id=@communities.community_id@" referer="@referer@">)
</if>
<else>
        (<include src="deregister" url="community-deregister?community_id=@communities.community_id@" referer="@referer@">)
</else>
      </td>
      <td>
<if @communities.admin_p@ eq "t">
        (<a href="@communities.url@one-community-admin">admin</a>)
</if>
      </td>
    </tr>
</multiple>
  </table>
</if>
