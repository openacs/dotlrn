<if @communities:rowcount@ gt 0>
  <h3>Communities</h3>
  <table cellpadding="5" cellspacing="5">
<multiple name="communities">
    <tr>
      <td><a href="@communities.url@">@communities.pretty_name@</a></td>
      <td> 
<if @communities.member_p@ eq "f">
        (<a href="@communities.url@community-register">register</a>)
</if>
<else>
        (<a href="@communities.url@community-deregister">deregister</a>)
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
<else>
  <blockquote>Currently, there are no active communities.</blockquote>
</else>
