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

<master src="dotlrn-admin-master">
<property name="title">@title@</property>
<property name="context_bar">@context_bar@</property>

<center>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left" style="white-space: nowrap; font-size: x-small;">
        [
          <a href="department-new?referer=@referer@">#dotlrn.new_department#</a>
        ]
      </td>
    </tr>
  </table>

  <br>

  <table bgcolor="#cccccc" cellpadding="5" width="95%">

    <tr>
      <th align="left">#dotlrn.department_name#</th>
      <th align="center" width="10%">#dotlrn.Actions#</th>
    </tr>

    <if @departments:rowcount@ gt 0>

      <multiple name="departments">

        <if @departments.rownum@ odd>
          <tr bgcolor="#eeeeee">
        </if>
        <else>
          <tr bgcolor="#d9e4f9">
        </else>
        
        <td align="left">
          <a href="department?department_key=@departments.department_key@">@departments.pretty_name@</a>
        </td>
        
        <td align="center" style="white-space: nowrap; font-size: x-small;">
        
          <if @can_create@>
            [
              <a href="class-new?department_key=@departments.department_key@&referer=department?department_key=@departments.department_key@">#dotlrn.new_class_1#</a>
            
            <if @departments.n_classes@ eq 0>
            |
              <a href="department-delete?department_key=@departments.department_key@&pretty_name=@departments.pretty_name@&referer=departments">#dotlrn.Delete#</a>
            </if>
            ]
          </if>
        </td>

          </tr>
      
      </multiple>

    </if>
    <else>
      <tr bgcolor="#eeeeee">
        <td align="left" colspan="2">
          <em>#dotlrn.no_departments#</em>
        </td>
      </tr>
    </else>
  </table>

<if @departments:rowcount@ gt 10>
  <br>

  <table cellpadding="5" width="95%">
    <tr>
      <td align="left">
        <nobr>
          <small>[
            <a href="department-new?referer=@referer@">#dotlrn.new_department#</a>
          ]</small>
        </nobr>
      </td>
    </tr>
  </table>
</if>

</center>



