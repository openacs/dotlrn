<master src="./master">
<property name="title">dotLRN Admin: Add a User to a Community</property>

You're adding <strong>@first_names@ @last_name@ (@email@)</strong>:<p>

<form method="get" action="community-user-add-3">
  <input type="hidden" name="user_id" value="@user_id@">
  Role: 
  <select name="rel_type">
<multiple name="roles">
    <option value="@roles.rel_type@"> @roles.pretty_name@
</multiple>
  </select>
  <input type="submit" value="add">
</form>
