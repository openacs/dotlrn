<master>
<property name="title">@title@</property>
<property name="portal_id">@portal_id@</property>
<property name="link_all">1</property>
<property name="return_url">./</property>
<property name="link_control_panel">0</property>

<ul>
  <li><a href="/pvt/home">Edit My Profile</a></li>
  <li><a href="/user/password-update">Change My Password</a></li>
  <li>Edit My Bulletin Board Email Alerts</li>
  <li><a href="configure">Customize This Portal</a></li>
<if @admin_p@ eq 1>
  <li><a href="@admin_url@">Site-wide Administration</a></li>
</if>
</ul>

<p></p>

<blockquote>
  <include src="my-communities" title="Groups" referer="preferences">
</blockquote>
