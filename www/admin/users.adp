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
<property name="title">#dotlrn.Users#</property>
<property name="context_bar">@context_bar;noquote@</property>

<% set referer "[dotlrn::get_admin_url]/users" %>

[<small>
  <a href="../user-add?add_membership_p=f&dotlrn_interactive_p=1&referer=@referer@"><small>#dotlrn.Create_A_New_User#</small></a> 
  |
  <a href="users-search"><small>#dotlrn.Search_Users#</small></a>
  |
  <a href="users-bulk-upload"><small>#dotlrn.Bulk_Upload#</small></a>
  |
  <a href="users-bulk-approve"><small>#dotlrn.Bulk_Approve#</small></a>
</small>]

<p></p>

<form method="get" action="users-search">
  #dotlrn.lt_Search_dotLRN_users_f# <input type="text" name="name"><input type="submit" value="#dotlrn.search#">

  <input type="hidden" name="form:id" value="user_search">

</form>

<form method="get" action="user-new">
  #dotlrn.lt_Add_a_new_dotLRN_user# <input type="text" name="search_text"><input type="submit" value="#dotlrn.search#">
</form>

<p></p>

<p>@control_bar;noquote@</p>

<if @n_users@ gt 500>
  <include src="users-chunk-large" type=@type@ referer="@referer@?type=@type@">
</if>
<else>
  <if @n_users@ gt 50>
    <include src="users-chunk-medium" type=@type@ referer="@referer@?type=@type@">
  </if>
  <else>
    <include src="users-chunk-small" type=@type@ referer="@referer@?type=@type@">
  </else>
</else>
