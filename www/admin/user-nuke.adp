<master src="dotlrn-admin-master">
<property name="title">Nuke @first_names@ @last_name@ (@email@)</property>
<property name="context_bar">@context_bar@</property>

<h3>Confirmation</h3>

<p>

Please confirm that you want eliminate all traces of @first_names@
@last_name@ (@email@) from the database.  If you select "Yes", we'll
make an attempt.  If we succeed, you'll be redirected to where you
were.  If there is an error and we are unable to complete the removal,
we'll return an error message.

<formtemplate id="confirm_delete"></formtemplate>