<master src="dotlrn-admin-master">
<property name="title">Error Nuking @first_names@ @last_name@ (@email@)</property>
<property name="context_bar">@context_bar@</property>

<h3>Sorry!</h3>

<p>

Well, we tried to nuke the user, but there was an error.  The most
likely case is that a reference to this user (user_id=@user_id@)
exists somewhere in the database schema.  It's time to call your
programmers!

<p>

<a href="@referer@">Return to where you were</a>.
