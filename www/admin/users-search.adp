<%

    #
    #  Copyright (C) 2001, 2002 MIT
    #
    #  This file is part of dotLRN.
    #
    #  dotLRN is free software; you can redistribute it and/or modify it under the
    #  terms of the GNU General Public License as published by the Free Software
    #  Foundation; either version 2 of the License, or (at your option) any later
    #  version.
    #
    #  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
    #  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    #  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
    #  details.
    #

%>

<master src="dotlrn-admin-master">
<property name="title">#dotlrn.Users_Search#</property>
<property name="context_bar">@context_bar;noquote@</property>

<p></p>

<if @is_request@ ne 0>
    <table width="60%" cellspacing="3" cellpadding="3">
    <formtemplate id="user_search">

      <tr>
        <th align="left">#dotlrn.Name__Email#</th>
        <td><formwidget id="name"></td>
      </tr>

      <tr>
        <th align="left">#dotlrn.ID#</th>
        <td><formwidget id="id"></td>
      </tr>

      <tr>
        <th align="left">#dotlrn.User_Type#</th>
        <td><formwidget id="type"></td>
      </tr>

      <tr>
        <th align="left">#dotlrn.Access_Level#</th>
        <td><formwidget id="can_browse_p"></td>
      </tr>

      <tr>
        <th align="left">#dotlrn.Guest#</th>
        <td><formwidget id="guest_p"></td>
      </tr>

      <tr>
        <th align="left">#dotlrn.Role#</th>
        <td>
          <formgroup id="role">
            @formgroup.widget;noquote@&nbsp;@formgroup.label@&nbsp;&nbsp;
          </formgroup>
        </td>
      </tr>

      <tr>
        <th align="left">#dotlrn.Last_visit_over#</th>
        <th align="left"><formwidget id="last_visit_greater"></th>
      </tr>

      <tr>
        <th align="left">#dotlrn.Last_visit_under#</th>
        <th align="left"><formwidget id="last_visit_less"></th>
      </tr>

      <tr>
        <th align="left">#dotlrn.lt_Join_the_above_criter#</th>
        <td><formwidget id="join_criteria"></td>
      </tr>

      <tr align="center">
        <td colspan="2"><input type="submit" value="#dotlrn.Search#"></td>
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
      #dotlrn.lt_Your_search_returned_#
    </p>
  </else>
</else>



