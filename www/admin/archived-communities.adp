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

<if @archived_comms:rowcount@ gt 0>
<table width="100%">
  <tr>
    <th align="left" width="15%">#dotlrn.Name#</th>
    <th align="left" width="50%">#dotlrn.Description#</th>
    <th align="left">#dotlrn.Actions#</th>
  </tr>
<multiple name="archived_comms">
  <tr>
    <td><a href="@archived_comms.url@">@archived_comms.pretty_name@</a></td>
    <td><pre>@archived_comms.description@</pre></td>
    <td></td>
  </tr>
</multiple>
</table>
</if>
<else>
  #dotlrn.no_arhived_groups#
</else>
