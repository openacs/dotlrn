<master src="master">
<property name="context_bar">@context_bar@</property>
<property name="title">dotLRN Community Admin: @pretty_name@</property>

Here you can do all sorts of administrative stuff.

<p>

<h3>Active Applets</h3>
<ul>
<multiple name=active_applets>
<li> @active_applets.applet_pretty_name@ - (cannot be removed yet)
</multiple>
</ul>

<p>
<h3>Applets to Add</h3>
<ul>
<multiple name=all_applets>
<li> @all_applets.applet_pretty_name@ - [<a href=applet-add?applet_key=@all_applets.applet_key@>add</a>]
</multiple>
</ul>
