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


<p>
  <a href="@add_user_url@" class="button">#dotlrn.Create_A_New_User#</a> 
  <a href="../member-search?return_url=./admin/users" class="button">#dotlrn.Search_Users#</a>
  <a href="users-bulk-upload" class="button">#dotlrn.Bulk_Upload#</a>
  <a href="users-bulk-approve" class="button">#dotlrn.Bulk_Approve#</a>
</p>

<form method="get" action="../member-search">
  #dotlrn.lt_Search_dotLRN_users_f# <input type="text" name="search_text"><input type="submit" value="#dotlrn.search#">
  <input type="hidden" name="form:id" value="user_search">
  <input type="hidden" name="return_url" value="./admin/users">
</form>

<form method="get" action="../member-search">
  #dotlrn.lt_Add_a_new_dotLRN_user# <input type="text" name="search_text"><input type="submit" value="#dotlrn.search#">
  <input type="hidden" name="return_url" value="./admin/users">
</form>

@control_bar;noquote@

<if @n_users@ gt 500>
  <include src="users-chunk-large" type=@type@ referer="@referer;noquote@">
</if>
<else>
  <if @n_users@ gt 50>
    <include src="users-chunk-medium" type=@type@ referer="@referer;noquote@">
  </if>
  <else>
    <include src="users-chunk-small" type=@type@ referer="@referer;noquote@">
  </else>
</else>
