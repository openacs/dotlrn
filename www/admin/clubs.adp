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
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

<center>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="club-new">#dotlrn.new_community#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

  <br>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">

    <tr>
      <th align="left" width="30%">#dotlrn.community_header_name#</th>
      <th align="left">#dotlrn.Description#</th>
      <th align="center" width="5%">#dotlrn.Members#</th>
      <th align="center" width="10%">#dotlrn.Actions#</th>
    </tr>

<if @clubs:rowcount@ gt 0>

<multiple name="clubs">

<if @clubs.rownum@ odd>
    <tr bgcolor="#eeeeee">
</if>
<else>
    <tr bgcolor="#d9e4f9">
</else>
      <td align="left"><a href="@clubs.url@">@clubs.pretty_name@</a></td>
      <td align="left">@clubs.description@</td>
      <td align="center">@clubs.n_members@</td>
      <td align="center">
        <nobr>
          <small>
             <a href="@clubs.url@one-community-admin">#dotlrn.administer_link#</a> 
          </small>
        </nobr>
      </td>
    </tr>

</multiple>

</if>
<else>
  <tr bgcolor="#eeeeee">
    <td align="left" colspan="4">
      <i>#dotlrn.no_communities#</i>
    </td>
  </tr>
</else>
  </table>

<if @clubs:rowcount@ gt 10>
  <br>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="club-new">#dotlrn.new_community#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>
</if>

</center>
