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
<property name="title">@first_names@ @last_name@</property>
<property name="context_bar">@context_bar@</property>

#dotlrn.user_has_been_a_member_since#

<if @member_state@ eq "deleted">

  <blockquote><font color="red">#dotlrn.this_user_is_deleted#</font></blockquote>

</if>
<else><if @member_state@ eq "banned">

  <blockquote><font color="red">#dotlrn.lt_this_user_is_deleted_#</font></blockquote>

</if></else>

<if @show_email_p@ eq 1>
  <ul>
    <li>#dotlrn.email#: <a href="mailto:@email@">@email@</a></li>

    <if @url@ not nil>
      <li>#dotlrn.Personal_home_page# <a href="@url@">@url@</a></li>
    </if>
	<if @weblog_p@ true>
	<multiple name="weblogs">
	<li><a href=@weblog_url@?forum_id=@weblogs.forum_id@>@weblogs.name@</a> - #dotlrn.Latest_post# @weblogs.lastest_post@
        </multiple>
        </if>
    <if @bio@ not nil>
      <p> <em>#dotlrn.Biography#</em> @bio@
    </if>
  </ul>
</if>
<else>
  <if @url@ not nil>
    <ul><li>#dotlrn.Personal_home_page# <a href="@url@">@url@</a></li></ul>
  </if>
</else>

<if @portrait_p@ eq 1>

  <if @inline_portrait_state@ eq "inline">
  
    <a href="/shared/portrait?@portrait_export_vars@"><img src="/shared/portrait-bits?@portrait_export_vars@" align="right" width="@width@" height="@height@"></a><br>
  
  </if>
  <if @inline_portrait_state@ eq "link">
  
      <ul><li><a href="/user/portrait?@portrait_export_vars@">Portrait</a></li></ul>
  
  </if>
</if>

<if @folder_id@ not nil>
<h3>#dotlrn.Shared_Files#</h3>

<include src=@scope_fs_url@ folder_id=@folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@">
</if>

<multiple name="user_contributions">
  <h3>@user_contributions.pretty_plural@</h3>
  <ul>
<group column="pretty_name">
    <li>@creation_date@: @user_contributions.object_name@
</group>
  </ul>
</multiple>



