  <if @show_p@ true>
    <table id="dotlrn-toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" >
      <tr>
	<td id="title">
	  <a href="http://www.dotlrn.org/"> .LRN</a>
	</td>

	<td class="dt-action-list">
	  <a href="@dotlrn_url@" title="Dotlrn Home">Home</a>
	  <span style="color: #cccccc;">|</span>
	  
	  <a href="@dotlrn_admin_url@/terms" title="#dotlrn.Terms#">#dotlrn.Terms#</a>
	  <span style="color: #cccccc;">|</span>
	  
	  <a href="@dotlrn_admin_url@/departments" title="#dotlrn.departments_pretty_plural#">#dotlrn.departments_pretty_plural#</a>
	  <span style="color: #cccccc;">|</span>
	  
	  <a href="@dotlrn_admin_url@/classes" title=""#dotlrn.classes_pretty_plural#">#dotlrn.classes_pretty_plural#</a>
	  <span style="color: #cccccc;">|</span>
	  
	  <a href="@dotlrn_admin_url@/term?term_id=-1" title="#dotlrn.Classes#">#dotlrn.Classes#
	  <span style="color: #cccccc;">|</span>
	  
	  <a href="@dotlrn_admin_url@/clubs" title="#dotlrn.clubs_pretty_plural#">#dotlrn.clubs_pretty_plural#</a>
	  <span style="color: #cccccc;">|</span>

	  <a href="@dotlrn_admin_url@/users" title=""#dotlrn.Users#">#dotlrn.Users#</a>
	  <span style="color: #cccccc;">|</span>

	  <a href="@dotlrn_admin_url@/" title="Dotlrn admin">#dotlrn.Admin#</a>
	  <span style="color: #cccccc;">|</span>
  
	  <a href="@dotlrn_admin_url@/toolbar-actions?action=@info_action@&return_url=@return_url@" title="@info_title@">@info_title@</a>
	</td>
	
	<form action="@dotlrn_admin_url@/toolbar-actions" method="POST">
	  <input type="hidden" name="action" value="search">
	    <td id="search">
	      Search:
	      <input name="keyword" onfocus="if(this.value=='.LRN Search')this.value='';" onblur="if(this.value=='')this.value='.LRN Search';" value=".LRN Search">
		in:<select name="search_type"><option value="users">Users</option><option value="departments">Departments</option><option value="subjects">Subjects</option><option value="classes">Classes</option></select>
		<input type="submit" value="Search">
	    </td>
	</form>

	<td>
	  <a href="@dotlrn_admin_url@/toolbar-actions?action=hide&return_url=@return_url@" style="font-size:80%;" title="Hide me">Hide me</a>
	</td>	
      </tr>
      
      <if @info_show_p@ eq 1>
	<tr>
	  <td colspan="4" class="general-info">
	    <ul>
	      <li><i>my user_id:</i> <span> @user_id@ </span> </li>
	      <li><i>context_id:</i> <span> @package_id@ </span></li>
	      <li><i>community_id:</i> <span> @community_id@  </span> </li>
	      <li><i>portal_id:</i> <span> @portal_id@ </span> </li>
          <li><i>package_id:</i> <span>@package_id@</span> </li>
	    </ul>
	  </td>
	</tr>
	
      </if>
    </table>
  </if>
