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

<!--
  @author Ben Adida (ben@openforce.net)
  @author yon (yon@openforce.net)
  @version $Id$
-->

<master src="dotlrn-admin-master">
<property name="title">@admin_pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<ul>
  <li><a href="users">Users</a></li>
  <li><a href="terms">Terms</a></li>
  <li><a href="departments"><%= [ad_parameter "departments_pretty_plural"] %></a></li>
  <li><a href="classes"><%= [ad_parameter "classes_pretty_plural"] %></a></li>
  <li><a href="term?term_id=-1"><%= [ad_parameter "class_instances_pretty_plural"] %></a></li>
  <li><a href="clubs"><%= [ad_parameter "clubs_pretty_plural"] %></a></li>
  <li><a href="edit-preapproved-emails">Edit Pre-approved Email Servers</a></li>
  <li><a href="portal-templates">Portal Templates</a></li>
</ul>
