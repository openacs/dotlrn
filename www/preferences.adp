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
<property name="title">@title@</property>
<property name="portal_id">@portal_id@</property>
<property name="link_all">1</property>
<property name="return_url">./</property>
<property name="link_control_panel">0</property>

<ul>
  <li><a href="/pvt/home">Edit My Profile</a></li>
  <li><a href="/user/password-update?return_url=@referer@">Change My Password</a></li>
  <li><a href="applets/bboard/alerts">Edit My Bulletin Board Email Alerts</a></li>
  <li><a href="configure">Customize This Portal</a></li>
<if @admin_p@ eq 1>
  <li><a href="@admin_url@">dotLRN Administration</a></li>
</if>
</ul>

<blockquote>
  <include src="my-communities" title="Groups" referer="preferences">
</blockquote>
