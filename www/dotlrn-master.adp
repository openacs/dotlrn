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
@header_stuff@


</head>
<body<multiple name=attribute> @attribute.key@="@attribute.value@"</multiple>>

<!-- Header Begin -->
<if @user_id@ ne 0>
  <!-- User is logged in with user id @user_id@ -->
  <table width="100%" cellpadding=0 cellspacing=2> 
   <tr>
      <td width="10%" class="header-logo">
        <a href="@dotlrn_url@/?">
        <img class="header-img" border=0 src="@header_img_url@" alt="@header_img_alt_text@"></a>
      </td>

      <td><div class=header-text><nobr>@text@<nobr></div></td>

      <td align="right" class="header-text">
        @user_name@
      </td>

    <tr>
      <td colspan=3 class="header-buttons" align="right" valign="bottom">
        <a href="@dotlrn_url@/?"><img class="header-img" border="0" src="@dotlrn_url@/graphics/myspace-@scope_name@.gif" alt="MySloanSpace"></a>
        <img class="header-img" src="@dotlrn_url@/graphics/spacer.gif" height="1" width="10">
        <a href="@help_url@"><img class="header-img" border="0" src="@dotlrn_url@/graphics/help-@scope_name@.gif" alt="Help"></a>
        <img class="header-img" src="@dotlrn_url@/graphics/spacer.gif" height="1" width="10">
        <a href="/register/logout"><img class="header-img" border="0" src="@dotlrn_url@/graphics/logout-@scope_name@.gif" alt="Logout"></a>
      </td>
  
    </tr>

  <tr><td colspan=3 class="dark-line" height="1"><img src="@dotlrn_url@/graphics/spacer.gif"></td></tr>

  <!-- navbars on every page -->
  <tr><td colspan=3 valign=top>@navbar@</td></tr>
  </table>
  <p>
  <p>
</if>
<else>
  <!-- User is not logged in so we cannot use pretty header with graphics under dotlrn -->
  <h1> .LRN </h1>
  <hr />
</else>
<!-- Header End -->

<slave>


<!-- Footer Begin -->
<if @user_id@ ne 0>
  <!-- User is logged in -->

  <!-- dotLRN info links -->
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td><small>@navbar@</small></td></tr>
    <tr><td colspan=3 class="dark-line" height="1"><img src="@dotlrn_url@/graphics/spacer.gif"></td></tr>
  </table>
</if>
<else>
  <!-- User is not logged in so we cannot display pretty footer with graphics under dotlrn -->
  <hr />
</else>

  <p>
    <div class="footer">
      <a href="http://www.dotlrn.org">dotLRN Home</a> | 
      <a href="http://www.openacs.org/projects/dotlrn">dotLRN Project Central</a>
    </div>

    <div class="footer">@ds_link@</div>
  </p>

</body>
</html>
