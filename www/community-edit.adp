<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->

<master src="dotlrn-master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

<p>
  <formtemplate id="edit_community_info"></formtemplate>
</p>

<p>
  <formtemplate id="edit_community_role_names"></formtemplate>
</p>

<p>

<!-- AKS: bypass form manager for the last form. But fake 
     the look and feel of it   -->
<form enctype=multipart/form-data method=POST action="community-edit-2">
<table bgcolor=#6699CC cellspacing=0 cellpadding=4 border=0>
<tr><td>
  <table bgcolor=#99CCFF cellspacing=0 cellpadding=6 border=0>
  <tr><td>
      <table bgcolor=#99CCFF cellspacing=0 cellpadding=2 border=0>
      <tr>
        <td><b>Header Font</b>&nbsp;&nbsp;</td>
        <td nowrap><input type="text" name="header_font" size="50" value="@header_font@" /></td>
      </tr>
      
      <tr>
        <td><b>Header Font Size</b>&nbsp;&nbsp;</td>
        <td nowrap>
        <select name="header_font_size">
          @size_option_list@
        </select>
        </td>
      </tr>
      
      <tr>
        <td><b>Header Font Color</b>&nbsp;&nbsp;</td>
        <td nowrap>
        <input type="text" name="header_font_color" value="@header_font_color@" size="50" /></td>
      </tr>

      <tr><td align=center colspan=2>
          <input type="submit" name="preview_button" value="Preview" /></td>
      </tr>
    
    </table>
  
  </td></tr>
  </table>

</td></tr>
</table>

</form>
</p>

<strong>[<a href=community-edit-revert.tcl>Revert all properties to defaults</a>]</strong>