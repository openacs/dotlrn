<!--
  @author Ben Adida (ben@openforce.net)
  @author yon (yon@openforce.net)
  @version $Id$
-->

<master src="master">
<property name="title">dotLRN Admin</property>
<property name="context_bar">@context_bar@</property>

<ul>
  <li><a href="users">Users</a></li>
  <li><a href="terms">Terms</a></li>
  <li><a href="classes"><%= [ad_parameter classes_pretty_plural] %></a></li>
  <li><a href="clubs"><%= [ad_parameter clubs_pretty_plural] %></a></li>
</ul>
