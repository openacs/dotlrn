<master src="../master">
<property name="title">dotLRN Admin: Add a User to a Community</property>

You're adding <strong>@first_names@ @last_name@ (@email@)</strong>:<p>

<FORM method=get action=community-user-add-3>
<INPUT TYPE=hidden name=user_id value=@user_id@>
<INPUT TYPE=hidden name=community_id value=@community_id@>
Role: 
<SELECT name=rel_type>
<multiple name="roles">
<OPTION value="@roles.rel_type@"> @roles.pretty_name@
</multiple>
</SELECT>

<INPUT TYPE=submit value=add>
</FORM>
