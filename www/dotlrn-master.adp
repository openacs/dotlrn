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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>@title@</title>
@header_stuff@
</head>
<body<multiple name="body_attributes"> @body_attributes.key@="@body_attributes.value@"</multiple>>

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
    <td class="header-logo">
      <a href="@dotlrn_url@">
      <img class="header-img" border=0 src="@header_img_url@" alt="@header_img_alt_text@"></a>
    </td>

    <td><div class=header-text>@text@</div></td>

    <td class="header-buttons">
      <img src="@color_1pixel@" width="9" height="9"> <a href="@dotlrn_url@">#dotlrn.myspace#</a>
      <img src="@color_1pixel@" width="9" height="9"> <a href="@dotlrn_url@/control-panel">#dotlrn.help#</a>
      <img src="@color_1pixel@" width="9" height="9"> <a href="/register/logout">#dotlrn.logout#</a>
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

<div style="font-size: small">@navbar@</div>

<P>

<slave>


<!-- Footer Begin -->

<P>

<div style="font-size: small">@navbar@</div>

<hr>

<div class="footer">
  <table width="100%" border="0" cellpadding="1" cellspacing="0">
    <tr>
      <td align=left valign=top>
        <a href="http://dotlrn.org">dotLRN</a>
        | 
        <a href="http://openacs.org">OpenACS</a>
        |
        <a href="@change_locale_url@">#dotlrn.Change_Locale#</a>
      </td>
      <td align=right>
        @ds_link@
      </td>
    </tr>
  </table>
</div>
