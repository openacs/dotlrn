<master src="master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

[ <a href="club-new">New <%= [ad_parameter clubs_pretty_name] %></a> ]

<p></p>

<if @clubs:rowcount@ gt 0>
<multiple name="clubs">
  <include src="club" club_id="@clubs.club_id@"
                      pretty_name="@clubs.pretty_name@"
                      description="@clubs.description@"
                      community_key="@clubs.community_key@"
                      url="@clubs.url@">
  <p></p>
</multiple>
</if>

<if @clubs:rowcount@ gt 10>
[ <a href="club-new">New <%= [ad_parameter clubs_pretty_name] %></a> ]
</if>
