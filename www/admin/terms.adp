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
<property name="title">Terms</property>
<property name="context_bar">@context_bar@</property>

<center>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="term-new">New Term</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>

  <br>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr>
      <th align="left">Term</th>
      <th align="center" width="15%">Start Date</th>
      <th align="center" width="15%">End Date</th>
      <th align="center" width="15%">Classes</th>
    </tr>

<if @terms:rowcount@ gt 0>

<multiple name="terms">

<if @terms.rownum@ odd>
    <tr bgcolor="#eeeeee">
</if>
<else>
    <tr bgcolor="#d9e4f9">
</else>
      <td align="left"><a href="term?term_id=@terms.term_id@">@terms.term_name@ @terms.term_year@</a></td>
      <td align="center">@terms.start_date@</td>
      <td align="center">@terms.end_date@</td>
      <td align="center">@terms.n_classes@</td>
    </tr>

</multiple>

</if>
<else>
  <tr bgcolor="#eeeeee">
    <td align="left" colspan="4">
      <i>No Terms</i>
    </td>
  </tr>
</else>
  </table>

<if @terms:rowcount@ gt 10>
  <br>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="term-new">New Term</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>
</if>

</center>
