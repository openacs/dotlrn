<master src="master">
<property name="title">Users Search</property>
<property name="context_bar">@context_bar@</property>

<p></p>

<if @is_request@ ne 0>
    <table width="60%" cellspacing="3" cellpadding="3">
    <formtemplate id="user_search">

      <tr>
        <th align="left">Name / Email</th>
        <td><formwidget id="name"></td>
      </tr>

      <tr>
        <th align="left">ID</th>
        <td><formwidget id="id"></td>
      </tr>

      <tr>
        <th align="left">User Type</th>
        <td><formwidget id="type"></td>
      </tr>

      <tr>
        <th align="left">Access Level</th>
        <td><formwidget id="access_level"></td>
      </tr>

      <tr>
        <th align="left">Guest?</th>
        <td><formwidget id="private_data_p"></td>
      </tr>

      <tr>
        <th align="left">Role</th>
        <td>
          <formgroup id="role">
            @formgroup.widget@&nbsp;@formgroup.label@&nbsp;&nbsp;
          </formgroup>
        </td>
      </tr>

      <tr>
        <th align="left">Last visit over</th>
        <th align="left"><formwidget id="last_visit_greater">&nbsp; days ago</th>
      </tr>

      <tr>
        <th align="left">Last visit under</th>
        <th align="left"><formwidget id="last_visit_less">&nbsp; days ago</th>
      </tr>

      <tr>
        <th align="left">Join the above criteria with</th>
        <td><formwidget id="join_criteria"></td>
      </tr>

      <tr align="center">
        <td colspan="2"><input type="submit" value="Search"></td>
      </tr>

    </formtemplate>
  </table>
</if>
<else>
  <if @n_users@ gt 0>
    <formtemplate id="user_search_results">
    </formtemplate>
  </if>
  <else>
    <p>
      Your search returned no results, please broaden your search criteria.
    </p>
  </else>
</else>
