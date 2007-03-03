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

<if @community_types:rowcount@ gt 0>
  <h2><if @title@ nil>#dotlrn.Community_Types#</if><else>@title@</else></h2>
  <table cellpadding="5" cellspacing="5">
<multiple name="community_types">
    <tr>
      <td><a href="@community_types.url@">@community_types.pretty_name@</a></td>
    </tr>
</multiple>
  </table>
</if>



