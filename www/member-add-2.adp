<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
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

<master src="dotlrn-master">
<property name="title">Add A Member To A Community</property>

You're adding <strong>@first_names@ @last_name@ (@email@)</strong>:<p>

<form method="get" action="member-add-3">
  <input type="hidden" name="user_id" value="@user_id@">
  <input type="hidden" name="referer" value="@referer@">
  Role:
  <select name="rel_type">
<multiple name="roles">
    <option value="@roles.rel_type@">@roles.pretty_name@</option>
</multiple>
  </select>
  <input type="submit" value="add">
</form>
