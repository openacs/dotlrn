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
<property name="title">@first_names@ @last_name@</property>
<property name="context_bar">@context_bar@</property>

<h3>General Information</h3>

<ul>

  <li>
    Name:
    @first_names@ @last_name@
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">Edit</a> </small>]
  </li>

  <li>
    Email:
    <a href="mailto:@email@">@email@</a>
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">Edit</a> </small>]
  </li>

  <li>
    Screen name:
    @screen_name@
    [<small> <a href="/user/basic-info-update?@export_edit_vars@">Edit</a> </small>]
  </li>

  <li>
    User ID:
    @user_id@
  </li>

  <li>
    Registration date:
    @registration_date@
  </li>

<if @last_visit@ not nil>
  <li>
    Last Visit:
    @last_visit@
  </li>
</if>

<if @portrait_p@ eq 1>
  <li>
    Portrait: <a href="/shared/portrait?user_id=@user_id@">@portrait_title@</a>
  </li>
</if>

  <li>
    Member state:
    @member_state@
    @change_state_links@
  </li>

</ul>

<h3>dotLRN Information</h3>

<if @dotlrn_user_p@ eq 1>

<ul>

  <li>
    User type:
    @pretty_type@
  </li>

  <li>
    Access level:
    <if @access_level@ eq "full">Full</if><else>Limited</else>
  </li>

  <li>
    Guest?:
    <if @read_private_data_p@ eq "t">No</if><else>Yes</else>
  </li>

  <li>
    ID:
    <if @id@ nil>&lt;none set up&gt;</if><else>@id@</else>
  </li>

  <br>

  <li>
    <a href="user-edit?@export_edit_vars@">Edit</a> dotLRN properties for this user.
  </li>

</ul>

<if @member_classes:rowcount@ gt 0>
  <blockquote>
    <h4><%= [dotlrn::parameter class_instances_pretty_name] %> Memberships</h4>

    <ul>
<multiple name="member_classes">
      <li>
        <a href="@member_classes.url@">@member_classes.pretty_name@</a>
        @member_classes.term_name@ @member_classes.term_year@
        (@member_classes.role@)
      </li>
</multiple>
    </ul>
  </blockquote>
</if>

<if @member_clubs:rowcount@ gt 0>
  <blockquote>
    <h4><%= [dotlrn::parameter clubs_pretty_name] %> Memberships</h4>

    <ul>
<multiple name="member_clubs">
      <li>
        <a href="@member_clubs.url@">@member_clubs.pretty_name@</a>
        (@member_clubs.role@)
      </li>
</multiple>
    </ul>
  </blockquote>
</if>

<if @member_subgroups:rowcount@ gt 0>
  <blockquote>
    <h4><%= [dotlrn::parameter subcommunities_pretty_name] %> Memberships</h4>

    <ul>
<multiple name="member_subgroups">
      <li>
        <a href="@member_subgroups.url@">@member_subgroups.pretty_name@</a>
        (@member_subgroups.role@)
      </li>
</multiple>
    </ul>
  </blockquote>
</if>

  <ul>
    <li>
      <a
      href="users-add-to-community?users=@user_id@&referer=@return_url@">Add</a>
      this user to another group.
    </li>
  </ul>

</if>
<else>
<p>
  This user is not yet a member of dotLRN.
  <a href="user-new-2?user_id=@user_id@&referer=@return_url@">Make</a> them one.
</p>
</else>

<h3>Administrative Actions</h3>

<ul>
  <li><a href="/user/password-update?@export_edit_vars@">Update this user's password</a></li>
<if @portrait_p@>
  <br>
  <li><a href="/user/portrait/index.tcl?@export_edit_vars@">Manage this user's portrait</a></li>
</if>
  <br>
  <li><a href="/acs-admin/users/become?user_id=@user_id@">Become this user!</a></li>
</ul>
