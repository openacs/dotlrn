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

<master src="dotlrn-admin-master">
<property name="title">@pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<ul>

  <li>
    External URL:
<if @external_url@ not nil>
    <a href="@external_url@">@external_url@</a>
</if>
<else>
    &lt;none set up&gt;
</else>
  </li>

  <li>
    Description:
<if @description@ not nil>
    <pre>@description@</pre>
</if>
<else>
    &lt;none set up&gt;
</else>
  </li>

  <br>

  <li>
    <a
    href="department-edit?department_key=@department_key@&referer=@referer@">Edit</a>
    department properties.
  </li>

</ul>

<br>

<include src="classes-chunk" department_key="@department_key@">
