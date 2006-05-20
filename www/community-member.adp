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
<property name="context">@context;noquote@</property>

<p>
<a href="@return_url;noquote@" title="Go back" class="button">Go back</a>
</p>
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
      <li>#dotlrn.Personal_home_page# <a href="@homepage_url@">@homepage_url@</a></li>
    </if>
	<if @forums_p@ true>
	<multiple name="forumss">
	<li><a href=@forums_url@?forum_id=@forums.forum_id@>@forums.name@</a> - #dotlrn.Latest_post# @forums.lastest_post@
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
  
      <ul><li><a href="/shared/portrait?@portrait_export_vars@">#dotlrn.Portrait_1#</a></li></ul>
  
  </if>
</if>

<include src="/packages/dotlrn/lib/bio" user_id="@user_id@" community_id="@community_id@" return_url="@return_url_2;noquote@">
