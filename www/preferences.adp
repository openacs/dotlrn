<master src="master">
<property name="title">@title@</property>

<ul>
  <li><a href="/pvt/home">Edit My Profile</a></li>
  <li><a href="/user/password-update">Change My Password</a></li>
  <li>Edit My Bulletin Board Email Alerts</li>
  <li><a href="configure">Customize This Portal</a></li>
<if @admin_p@ eq 1>
  <li><a href="@admin_url@">dotLRN Administration</a></li>
</if>
</ul>

<p></p>

<blockquote>
  <include src="my-communities" title="My Groups">
</blockquote>
