<% ns_log notice "XXX ADP" %>
<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">dotLRN: @pretty_name@</property>
<p>
<blockquote>
@description@
</blockquote>

<p>

<if @active_communities:rowcount@ eq 0>
<i>No Active Communities of this type</i>
</if>
<else>
<h3>Active Communities of this Type</h3>
<ul>
<multiple name=active_communities>
<li><a href=@active_communities.url@>@active_communities.pretty_name@</a> <if @active_communities.admin_p@ eq 1>(<a href=@active_communities.url@one-community-admin>admin</a>)</if>
</multiple>
</ul>
</else>

<p>
</ul>

