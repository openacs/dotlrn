<master src="master">
<property name="title">Add A Member To A Community</property>
<property name="portal_id">@portal_id@</property>

You're adding <strong>@first_names@ @last_name@ (@email@)</strong>:<p>

<form method="get" action="member-add-3">
  <input type="hidden" name="user_id" value="@user_id@">
  <input type="hidden" name="referer" value="@referer@">
  Role:
  <select name="rel_type">
<multiple name="roles">
    <option value="@roles.rel_type@"> @roles.pretty_name@
</multiple>
  </select>
  <input type="submit" value="add">
</form>
