<master src="/www/blank-master">
<%

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


    # /www/dotlrn-default-master.adp
    #
    # This is the 'default-master' template for dotlrn sites. 
    # 
    # Author: Arjun Sanyal (arjun@openforce.net), yon@openforce.net
    #
    # $Id$


%>    

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>@title@</title>
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/lists.css" media="all">
<link rel="stylesheet" type="text/css" href="/resources/acs-templating/forms.css" media="all">
<link rel="stylesheet" type="text/css" href="/resources/dotlrn/dotlrn-master.css" media="all">
@header_stuff;noquote@
</head>
<body<multiple name=attribute> @attribute.key@="@attribute.value@"</multiple>>

  <!-- Header Begin -->

  <table width="100%" cellpadding=0 cellspacing=0> 
   <tr>
      <td class="header-logo">
        <a href="@dotlrn_url@/?">
        <img class="header-img" border="0" src="@header_img_url@" alt="@header_img_alt_text@"></a>
      </td>

      <td>@text;noquote@</td>

      <td align="right" class="header-text">
        @user_name@
      </td>
    </tr>
    <tr>

      <td colspan=3 class="header-buttons" align="right" valign="bottom">
        <a href="@dotlrn_url@/?">#dotlrn.user_portal_page_home_title#</a>
        <img class="header-img" src="/resources/dotlrn/spacer.gif" height="1" width="10">
        <a href="@help_url@">#dotlrn.help#</a>
        <img class="header-img" src="/resources/dotlrn/spacer.gif" height="1" width="10">
        <a href="/register/logout">#dotlrn.logout#</a>
      </td>
  
    </tr>

  <tr><td colspan=3 class="dark-line" height="1"><img src="/resources/dotlrn/spacer.gif"></td></tr>

  <if @in_dotlrn_p@ true>  
      <!-- navbars on every page -->
    <tr><td colspan=3 valign=top>@navbar;noquote@</td></tr>
    </table>
    <p>
    <p>
  </if>
  <else>
    </table>
    <h1>@title@</h1>
    <if @context_bar@ not nil>
      <p>@context_bar;noquote@</p>
    </if>
  </else>

    <!-- Header End -->

  <slave>

  <if @curriculum_bar_p@ true>
    <p><include src="/packages/curriculum/lib/bar" />
  </if>

  <!-- Footer Begin: dotLRN info links -->

  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="clear: both;">
    <tr><td><small>@navbar;noquote@</small></td></tr>
    <tr><td colspan=3 class="dark-line" height="1"><img src="/resources/dotlrn/spacer.gif"></td></tr>
  </table>

  <!-- Footer End -->

  <p>
    <div class="footer">
      <a href="http://www.dotlrn.org">dotLRN Home</a> | 
      <a href="http://www.openacs.org/projects/dotlrn">dotLRN Project Central</a> | 
      <a href="@change_locale_url@">#dotlrn.Change_Locale#</a>
      <if @lang_admin_p@ true>| <a href="@toggle_translator_mode_url@">Toggle translator mode</a></if>
    </div>
    <div class="footer">@ds_link;noquote@</div>
  </p>

  <p>
    <include src="/packages/acs-lang/lib/messages-to-translate">
  </p>
</body>
</html>
