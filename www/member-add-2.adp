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

<master>
<property name="title">#dotlrn.Add_A_Member#</property>
<property name="context">#dotlrn.Add_A_Member#</property>
<if @member_p@ eq 1>

#dotlrn.lt_strongfirst_names_las#

</if>
<else>
#dotlrn.lt_You_are_adding_strong#<p>
</else>

<form method="get" action="member-add-3">
  <input type="hidden" name="user_id" value="@user_id@">
  <input type="hidden" name="referer" value="@referer@">
  #dotlrn.Role#
  <select name="rel_type">
<multiple name="roles">
    <option value="@roles.rel_type@"><%= [lang::util::localize @roles.pretty_name@] %></option>
</multiple>
  </select>
  <input type="submit" value="#acs-kernel.common_add#">
</form>
