<if @n_communities@ gt 0>
  <h3><if @title@ nil>Communities</if><else>@title@</else></h3>

  <p>@filter_bar@</p>

<if @communities:rowcount@ gt 0>
<multiple name="communities">
  <table>
<group column="root_community_type">
    <tr>
      <td width="65%"><a href="@communities.url@">@communities.pretty_name@</a></td>
      <td>
<if @communities.member_p@ eq 0>
        (<include src="register-link" url="register?community_id=@communities.community_id@&referer=@referer@">)
</if>
<else>
        (<include src="deregister-link" url="deregister?community_id=@communities.community_id@&referer=@referer@">)
</else>
      </td>
      <td>
<if @communities.admin_p@ eq 1>
        (<a href="@communities.url@one-community-admin">admin</a>)
</if>
      </td>
    </tr>
</group>
  </table>

  <p></p>
</multiple>
</if>
</if>
