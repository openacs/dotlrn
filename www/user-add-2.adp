<master src="master">
<property name="title">Add A User</property>
<property name="context_bar">@context_bar@</property>
<property name="portal_id">@portal_id@</property>

@first_names@ @last_name@ has been added to @system_name@.
Edit the message below and hit "Send Email" to
notify this user.

<p></p>

<form method="post" action="user-add-3">
  @export_vars@
  Message:

  <p></p>

  <textarea name="message" rows="10" cols="70" wrap="hard">
@first_names@ @last_name@,

You have been added as a user to @system_name@
at @system_url@

Login information:
Email: @email@
Password: @password@
(you may change your password after you log in)

Thank you,
@administration_name@
  </textarea>

  <p></p>

  <input type="submit" value="Send Email">
</form>
