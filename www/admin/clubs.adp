<master src="master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

[ <a href="club-new">New <%= [ad_parameter clubs_pretty_name] %></a> ]

<p></p>

<if @clubs:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left" width="15%"><%= [ad_parameter clubs_pretty_name] %> Name</th>
    <th align="left" width="50%">Description</th>
    <th align="left">Actions</th>
  </tr>
<multiple name="clubs">
  <tr>
    <td><a href="@clubs.url@">@clubs.pretty_name@</a></td>
    <td>@clubs.description@</td>
    <td>[&nbsp<font size="-1"><a href="@clubs.url@one-community-admin">admin</a></font>&nbsp;]</td>
  </tr>
</multiple>
</table>
</if>

<if @clubs:rowcount@ gt 10>
[ <a href="club-new">New <%= [ad_parameter clubs_pretty_name] %></a> ]
</if>
