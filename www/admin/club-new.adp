<master src="master">
<property name="title">dotLRN New Club</property>
<property name="context_bar">@context_bar@</property>

<form action="club-new-2" method=post>
  <table border=0>
    <tr>
      <td>Club Key (a short name, no spaces):</td>
      <td><input type=text name=key size=50></td>
    </tr>
    <tr>
      <td>Club Pretty Name:</td>
      <td><input type=text name=pretty_name size=50></td>
    </tr>
    <tr>
      <td valign=top>Description:</td>
      <td><textarea name=description cols=50 rows=5 wrap=soft></textarea></td>
    </tr>
  </table>
  <input type=submit value="Create Club">
</form>
