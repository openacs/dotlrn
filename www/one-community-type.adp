<master src="master">
<property name="title">dotLRN: @pretty_name@</property>
<p>
<blockquote>
@description@
</blockquote>

<ul>
<multiple name=communities>
<li><a href=@communities.url@>@communities.pretty_name@</a>
</multiple>
</ul>

<p>

<if @active_communities:rowcount@ eq 0>
<i>No Active Communities of this type</i>
</if>
<else>
<h3>Active Communities of this Type</h3>
<ul>
<multiple name=active_communities>
<li><a href=@active_communities.url@>@active_communities.pretty_name@</a>
</multiple>
</ul>
</else>

<p>
<a href=community-new>New Community of this Type</a>
<p>
</ul>

