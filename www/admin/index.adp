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

<!--
  @author Ben Adida (ben@openforce.net)
  @author yon (yon@openforce.net)
  @version $Id$
-->

<master src="dotlrn-admin-master">
<property name="title">@admin_pretty_name@</property>
<property name="context_bar">@context_bar@</property>

<ul>
  <li><a href="dotlrn-admins">#dotlrn.Administrators#</a></li> 
  <li><a href="users">#dotlrn.users#</a></li>
  <li><a href="terms">#dotlrn.terms#</a></li>
  <li><a href="departments"><%= [parameter::get -localize -parameter departments_pretty_plural] %></a></li>
  <li><a href="classes"><%= [parameter::get -localize -parameter classes_pretty_plural] %></a></li>
  <li><a href="term?term_id=-1"><%= [parameter::get -localize -parameter class_instances_pretty_plural] %></a></li>
  <li><a href="clubs"><%= [parameter::get -localize -parameter clubs_pretty_plural] %></a></li> 
  <li><a href="portal-templates">#dotlrn.portal_templates#</a></li>
  <li><a href="archived-communities">#dotlrn.archived_classes_and_communities#</a></li>
  <li><a href="edit-preapproved-emails">#dotlrn.edit_approved_email_servers#</a></li>
  <li><a href="@parameters_url@">#dotlrn.edit_parameters#</a></li>
  <li><a href="@parameters_d_url@">#dotlrn.edit_community_parameters#</a></li>
  <p>
  <if @oacs_site_wide_admin_p@ true>
    <li><a href="/acs-admin/">OpenACS Site-Wide Administration</a></li>
  </if>
  </p>
</ul>


