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

<master src="dotlrn-master">
<property name="title">@first_names@ @last_name@</property>
<property name="context_bar">@context_bar@</property>

<if @portrait_p@ eq 1>
  <if @inline_portrait_state@ eq "inline">
  
    <a href="portrait?@portrait_export_vars@"><img src="portrait-bits?@portrait_export_vars@" align="right" width="@width@" height="@height@"></a><br>
  
  </if>
  <else><if @inline_portrait_state eq "link">
  
    <li><a href="portrait?@portrait_export_vars@">Portrait</a>
  
  </if></else>
</if>

A member of the @system_name@ community since @pretty_creation_date@

<if @member_state@ eq "deleted">

  <blockquote><font color="red">this user is deleted</font></blockquote>

</if>
<else><if @member_state@ eq "banned">

  <blockquote><font color="red">this user is deleted and
  banned from the community.</font></blockquote>

</if></else>

<if @show_email_p@ eq 1>
  <ul>
    <li>E-mail @first_names@ @last_name@: <a href="mailto:@email@">@email@</a></li>

    <if @url@ not nil>
      <li>Personal home page: <a href="@url@">@url@</a></li>
    </if>

    <if @bio@ not nil>
      <p> <em>Biography:</em> @bio@
    </if>
  </ul>
</if>
<else>
  <if @url@ not nil>
    <ul><li>Personal home page: <a href="@url@">@url@</a></li></ul>
  </if>
</else>

<if @folder_id@ not nil>
<h3>Shared Files</h3>

  <include src="folder-chunk" folder_id=@folder_id@>
</if>

<multiple name="user_contributions">
  <h3>@user_contributions.pretty_plural@</h3>
  <ul>
<group column="pretty_name">
    <li>@creation_date@: @user_contributions.object_name@
</group>
  </ul>
</multiple>
