<master src="../master">
<property name="title">dotLRN Admin: Add a User</property>

You've chosen to add <strong>@first_names@ @last_name@</strong>. 
<p>

<FORM METHOD=get action=user-new-3>
<INPUT TYPE=hidden name=user_id value=@user_id@>

Choose a role: 

<SELECT name=role>
<OPTION value=guest> Guest
<OPTION value=student> Student
<OPTION value=professor> Professor
</SELECT>

<INPUT TYPE=submit value=add>
</FORM>


