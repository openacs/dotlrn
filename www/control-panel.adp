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

<table width="100%">
  <tr><td width="50%" valign="top">

    <div class="portlet-wrapper">
      <div class="portlet-title">
        <span><h2> #acs-subsite.My_Account# </h2></span>
      </div>
      <div class="portlet">
        <include src="/packages/acs-subsite/lib/user-info" />
  	<if @account_status@ eq "closed">
    	  #acs-subsite.Account_closed_workspace_msg#
  	</if>
        <ul>
          <li><a href="configure" title="#dotlrn.Customize_Layout#">#dotlrn.Customize_Layout#</a></li>
          <if @allowed_to_change_site_template_p@>
            <li><a href="change-site-template?referer=@dotlrn_url@/control-panel" title="#dotlrn.Customize_Template#">#dotlrn.Customize_Template#</a></li>
          </if>
          <li><a href="../user/password-update" title="#acs-subsite.Change_my_Password#">#acs-subsite.Change_my_Password#</a></li>

          <if @change_locale_url@ not nil>
            <li><a href="@change_locale_url@" title="acs-subsite.Change_locale_label#">#acs-subsite.Change_locale_label#</a></li>
          </if>

          <if @notifications_url@ not nil>
            <li><a href="@notifications_url@" title="#acs-subsite.Manage_your_notifications#">#acs-subsite.Manage_your_notifications#</a></li>
          </if>

          <if @account_status@ ne "closed">
            <li><a href="unsubscribe" title="#acs-subsite.Close_your_account#">#acs-subsite.Close_your_account#</a></li>
          </if>

          <if @admin_p@>
            <li><a href="@admin_url@" title="#dotlrn.goto_admin_pretty_name#">@admin_pretty_name@</a></li>
          </if>
        </ul>
      </div>
    </div>

    <if @portrait_state@ eq upload>
      <div class="portlet-wrapper">
        <div class="portlet-title">
          <span><h2>#acs-subsite.Your_Portrait#</h2></span>
        </div>
        <div class="portlet">
          <p>
            #acs-subsite.lt_Show_everyone_else_at#  <a href="@portrait_upload_url@" title="#acs-subsite.upload_a_portrait#">#acs-subsite.upload_a_portrait#</a>
          </p>
        </div>
      </div>
    </if>

    <if @portrait_state@ eq show>
      <div class="portlet-wrapper">  
        <div class="portlet-title">
          <span><h2>#acs-subsite.Your_Portrait#</h2></span>
        </div>
        <div class="portlet">
          <p>
            #acs-subsite.lt_On_portrait_publish_d#.
          </p>
          <table><tr valign="top"><td>
            <img height=100 src="/shared/portrait-bits.tcl?user_id=@user_id@" alt="#acs-subsite.Portrait#"><p>
            <a href="/user/portrait/?return_url=/pvt/home" title="#acs-subsite.Edit#">#acs-subsite.Edit#</a>
            </td><td>@portrait_description@</td></tr>
          </table>
        </div>
      </div>
    </if>

  </td>
  <td width="50%" valign="top">

    <div class="portlet-wrapper">
      <div class="portlet-title">
        <span><h2>#acs-subsite.Privacy#<h2></span>
      </div>
      <div class="portlet">
        <ul>
          <li><a href="@whos_online_url@" title="#acs-subsite.Whos_Online_link_label#">#acs-subsite.Whos_Online_link_label#</a></li>
          <li><a href="../user/email-privacy-level" title="#acs-subsite.Change_my_email_P#">#acs-subsite.Change_my_email_P#</a></li>
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
      </div>
    </div>

    <div class="portlet-wrapper">
      <div class="portlet-title">
        <span><h2>#dotlrn.General_Site_Help#</h2></span>
      </div>
      <div class="portlet">
        <ul>
          <li><a href="@dotlrn_url@/help" title="#dotlrn.help#">#dotlrn.help#</a></li>
          <li>#dotlrn.Ask_a_question# <a href="mailto:@system_owner@" title="#dotlrn.Ask_a_question#">@system_owner@</a></li>
        </ul>
      </div>
    </div>

  </td></tr>
</table>
