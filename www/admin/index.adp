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

<div class="portlet-wrapper">
	<div class="portlet-header">
		<div class="portlet-title-no-controls">
			@admin_pretty_name@
		</div>
	</div>
	<div class="portlet">
<ul>
  <li><a href="dotlrn-admins" title="#dotlrn.Administrators#">#dotlrn.Administrators#</a></li> 
  <li><a href="users" title="#dotlrn.users#">#dotlrn.users#</a></li>
  <li><a href="terms" title="#dotlrn.terms#">#dotlrn.terms#</a></li>
  <li><a href="departments" title="@departments_pretty_plural@">@departments_pretty_plural@</a></li>
  <li><a href="classes" title="@subjects_pretty_plural@">@subjects_pretty_plural@</a></li>
  <li><a href="term?term_id=-1" title="@class_instances_pretty_plural@">@class_instances_pretty_plural@</a></li>
  <li><a href="clubs" title="@clubs_pretty_plural@">@clubs_pretty_plural@</a></li> 
  <li><a href="portal-templates" title="#dotlrn.portal_templates#">#dotlrn.portal_templates#</a></li>
  <li><a href="site-templates" title="#dotlrn.site_templates#">#dotlrn.site_templates#</a></li>
  <li><a href="archived-communities" title="#dotlrn.archived_classes_and_communities#">#dotlrn.archived_classes_and_communities#</a></li>
  <li><a href="edit-preapproved-emails" title="#dotlrn.edit_approved_email_servers#">#dotlrn.edit_approved_email_servers#</a></li>
  <li><a href="@parameters_url@" title="#dotlrn.edit_parameters#">#dotlrn.edit_parameters#</a></li>
  <li><a href="@parameters_d_url@" title="#dotlrn.edit_community_parameters#">#dotlrn.edit_community_parameters#</a></li>
  <li><a href="@toolbar_actions_url@" title="@dotlrn_toolbar_action@">@dotlrn_toolbar_action@</a></li>
    </ul>

  <if @oacs_site_wide_admin_p@ true>
      <ul>
        <li><a href="/acs-admin/" title="#dotlrn.goto_oacs_swa#">OpenACS Site-Wide Administration</a></li>
      </ul>
  </if>
      </div>
    </div>


