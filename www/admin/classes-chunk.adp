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

<center>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">
    <tr bgcolor="#eeeeee">
      <th align="left" width="50%">
<formtemplate id="department_form">
        <%= [parameter::get -localize -parameter departments_pretty_name] %>:&nbsp;<formwidget id="department_key">
</formtemplate>
      </th>
    </tr>
  </table>

  <br>

<if @classes:rowcount@ gt 0>
        <listtemplate name="classes"></listtemplate>
</if>
<else>
</center>
<p align="right"><a href="class-new?department_key=@department_key@&referer=@referer@" class="button">#dotlrn.new_class_1#</a> </p>
<center>
<table>
  <tr bgcolor="#eeeeee">
    <td align="left" colspan="4">
      <i>#dotlrn.no_classes#</i>
    </td>
  </tr>
</table>
</else>

<br>
</center>
