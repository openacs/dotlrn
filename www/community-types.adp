<if @community_types:rowcount@ gt 0>
  <h3>Community Types</h3>
  <table cellpadding="5" cellspacing="5">
<multiple name="community_types">
    <tr>
      <td><a href="@community_types.url@">@community_types.pretty_name@</a></td>
    </tr>
</multiple>
  </table>
</if>
