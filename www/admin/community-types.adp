<master src="dotlrn-admin-master">
  <property name="title">@title@</property>
  <property name="context_bar">@context_bar@</property>
  
  <center>
    
    <table cellpadding="5" width="95%">
      <tr>
	<td align="left">
	  <nobr>
	    <small>[
	      <a href="community-type">#dotlrn.new_community_type#</a>
	      ]</small>
	  </nobr>
	</td>
      </tr>
    </table>
    
    <br>

    <table bgcolor="#cccccc" cellpadding="5" width="95%">

      <tr>
	<th align="left" width="20%">#dotlrn.Community_Type#</th>
	<th align="left" width="25%">#dotlrn.Pretty_Name#</th>
	<th align="left">#dotlrn.Description#</th>
      </tr>

      <if @community_types:rowcount@ gt 0>
	
	<multiple name="community_types">

	  <if @community_types.rownum@ odd>
	    <tr bgcolor="#eeeeee">
	  </if>
	  <else>
	    <tr bgcolor="#d9e4f9">
	  </else>
	  <td align="left"><a href="@community_types.edit_url@">@community_types.community_type@</a></td>
	  <td align="left">@community_types.pretty_name@</td>
	  <td align="left">@community_types.description@</td>
	</tr>

	</multiple>
	
      </if>
      <else>
	<tr bgcolor="#eeeeee">
	  <td align="left" colspan="4">
	    <i>#dotlrn.no_community_types#</i>
	  </td>
	</tr>
      </else>
    </table>

    <if @community_types:rowcount@ gt 10>
      <br>

	<table cellpadding="5" width="95%">
	  <tr>
	    <td align="left">
	      <nobr>
		<small>[
		    <a href="community-type">#dotlrn.new_community_type#</a>
		  ]</small>
	      </nobr>
	    </td>
	  </tr>
	</table>
    </if>

  </center>
	  
