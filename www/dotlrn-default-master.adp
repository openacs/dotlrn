<%

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
<body>

<!-- Header Begin -->
<table width="100%">
  <tr>
    <td colspan=3>
    <!-- Ugly NN4 bar hack -->
      <table width="100%" bgcolor="@color_hack@" border="0" cellpadding="1" cellspacing="0">
         <tr bgcolor="@color_hack@"> 
            <td><img src="@dotlrn_graphics_url@/spacer.gif" width="1" height="1" alt=""></td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td width="10%" class="header-logo">
      <a href="@dotlrn_url@">
      <img class="header-img" border=0 src="@header_img_url@" alt="@header_img_alt_text@"></a>
    </td>

    <td width="50%"><div class=header-text>@text@</div></td>

    <td width="40%" class="header-buttons" align="right">
      <a href="@dotlrn_url@"><img class="header-img" border="0" src="@dotlrn_graphics_url@/myspace-@color_hack_name@.gif" width="98" height="25" alt="MySloanSpace"></a>
      <a href="@dotlrn_url@/preferences"><img class="header-img" border="0" src="@dotlrn_graphics_url@/help-@color_hack_name@.gif" width="67" height="25" alt="Help"></a>
      <a href="/register/logout"><img class="header-img" border="0" src="@dotlrn_graphics_url@/logout-@color_hack_name@.gif" width="62" height="25" alt="Logout"></a>
    </td>

  </tr>

  <tr>
    <td colspan=3>
      <table width="100%" bgcolor="@color_hack@" border="0" cellpadding="1" cellspacing="0">
         <tr bgcolor="@color_hack@"> 
            <td><img src="@dotlrn_graphics_url@/spacer.gif" width="1" height="1" alt=""></td>
        </tr>
      </table>
    </td>
  </tr>
  
</table>

<!-- navbars on every page -->

<small>@navbar@</small>

<P>
<!-- Header End -->



<slave>


<!-- Footer Begin -->

<!-- navbars on every page -->
<P>

<small>@navbar@</small>


<hr>

<div class="footer"><a href="http://mitsloan.mit.edu">MIT Sloan School of Management</a> | <a href="http://web.mit.edu">MIT</a></div>

<div class="footer">@ds_link@</div>

</body>
</html>
