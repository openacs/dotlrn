<if @active_applets:rowcount@ gt 0>
<h3>Active Applets</h3>
<ul>
<multiple name="active_applets">
  <li>@active_applets.applet_pretty_name@ - (cannot be removed)</li>
</multiple>
</ul>
</if>

<if @all_applets:rowcount@ gt 0>
<p></p>

<h3>Applets To Add</h3>
<ul>
<multiple name="all_applets">
  <li>
    @all_applets.applet_pretty_name@ - [
      <font size="-1">
        <a href=applet-add?applet_key=@all_applets.applet_key@>add</a>
      </font>
    ]
  </li>
</multiple>
</ul>
</if>
