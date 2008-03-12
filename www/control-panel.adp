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
<property name="title">@title@</property>
<property name="link_control_panel">0</property>
<property name="context">@context;noquote@</property>

<div id="main-content-sim">
	<div class="main-content-padding">

    <div class="portlet-wrapper">
		<div class="portlet-header">
			<div class="portlet-title-no-controls">
				<h1> #acs-subsite.My_Account# </h1>
      		</div>
		</div>
		<div class="portlet">
			<include src="@user_info_template@" />
			<if @account_status@ eq "closed">
				#acs-subsite.Account_closed_workspace_msg#
			</if>
				<if @allowed_to_change_site_template_p@>
					<a href="change-site-template?referer=@dotlrn_url@/control-panel" title="#dotlrn.Customize_Template#" class="button">#dotlrn.Customize_Template#</a>
				</if>
				
				<if @change_locale_url@ not nil>
					<a href="@change_locale_url@" title="#acs-subsite.Change_locale_label#" class="button">#acs-subsite.Change_locale_label#</a>
				</if>

				<if @notifications_url@ not nil>
					<a href="@notifications_url@" title="#acs-subsite.Manage_your_notifications#" class="button">#acs-subsite.Manage_your_notifications#</a>
				</if>

				<a href="configure" title="#dotlrn.Customize_Layout#" class="button">#dotlrn.Customize_Layout#</a>

				<a href="../user/password-update" title="#acs-subsite.Change_my_Password#" class="button">#acs-subsite.Change_my_Password#</a>

				<if @account_status@ ne "closed">
					<a href="/pvt/unsubscribe" title="#acs-subsite.Close_your_account#" class="button">#acs-subsite.Close_your_account#</a>
				</if>

				<if @admin_p@>
					<a href="@admin_url@" title="#dotlrn.goto_admin_pretty_name#" class="button">@admin_pretty_name@</a>
				</if>
		</div> <!-- /portlet -->
	</div><!-- /portlet-wrapper -->

    <if @portrait_state@ eq upload>
		<div class="portlet-wrapper">
        	<div class="portlet-header">
				<div class="portlet-title-no-controls">
          			<h1>#acs-subsite.Your_Portrait#</h1>
        		</div>
			</div>
		
        	<div class="portlet">
				<p>#acs-subsite.lt_Show_everyone_else_at#  <a href="@portrait_upload_url@" title="#acs-subsite.upload_a_portrait#">#acs-subsite.upload_a_portrait#</a></p>
			</div> <!-- /portlet -->
		</div><!-- /portlet-wrapper -->
    </if>

    <if @portrait_state@ eq show>
		<div class="portlet-wrapper">
        	<div class="portlet-header">
				<div class="portlet-title-no-controls">
          			<h1>#acs-subsite.Your_Portrait#</h1>
        		</div>
			</div>
        	<div class="portlet">
          		<p>#acs-subsite.lt_On_portrait_publish_d#.</p>
          		<table>
					<tr valign="top">
						<td>
            				<img height=100 src="/shared/portrait-bits.tcl?user_id=@user_id@" alt="#acs-subsite.Portrait#"><p>
            				<a href="/user/portrait/?return_url=/pvt/home" title="#acs-subsite.Edit#">#acs-subsite.Edit#</a>
            			</td>
						<td>@portrait_description@</td>
					</tr>
          		</table>
			</div> <!-- /portlet -->
		</div><!-- /portlet-wrapper -->
    </if>

</div>
</div>

<div id="sidebar-1-sim">
	<div class="sidebar-1-padding">

    <div class="portlet-wrapper">
    	<div class="portlet-header">
			<div class="portlet-title-no-controls">
				<h1>#acs-subsite.Privacy#</h1>
			</div>
		</div>
		<div class="portlet">
			<ul>
				<li><a href="@community_member_url@">#acs-subsite.lt_What_other_people_see#</a></li>
				<li><a href="@whos_online_url@">#acs-subsite.Whos_Online_link_label#</a></li>
				<li><a href="../user/email-privacy-level">#acs-subsite.Change_my_email_P#</a></li>
			</ul>

        <if @invisible_p@ true>
          #acs-subsite.Currently_invisible_msg#
          <ul>
            <li><a href="@make_visible_url@" title="#acs-subsite.Make_yourself_visible_label#">#acs-subsite.Make_yourself_visible_label#</a></li>
          </ul>
        </if>
        <else>
          #acs-subsite.Currently_visible_msg#
          <ul>
            <li><a href="@make_invisible_url@" title="#acs-subsite.Make_yourself_invisible_label#">#acs-subsite.Make_yourself_invisible_label#</a></li>
          </ul>
        </else>
		</div> <!-- /portlet -->
	</div><!-- /portlet-wrapper -->

	<div class="portlet-wrapper">
    	<div class="portlet-header">
			<div class="portlet-title-no-controls">
				<h1>#dotlrn.General_Site_Help#</h1>
			</div>
		</div>
		<div class="portlet">
			<ul>
				<li><a href="@dotlrn_url@/help" title="#dotlrn.help#">#dotlrn.help#</a></li>
				<li>#dotlrn.Ask_a_question# <a href="mailto:@system_owner@" title="#dotlrn.Ask_a_question#">@system_owner@</a></li>
			</ul>
		</div> <!-- /portlet -->
	</div><!-- /portlet-wrapper -->

</div>
</div>