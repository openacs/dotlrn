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
    <property name="title">@pretty_name@</property>
    <property name="context_bar">@context_bar@</property>

    <ul>

      <li>
	#dotlrn.description#:
	<if @description@ not nil>
	  @description@
	</if>
	<else>
	  &lt;#dotlrn.no_description#&gt;
	</else>
      </li>

      <br>

	<li>
	  <a href="class-edit?class_key=@class_key@&referer=@referer@">#dotlrn.edit_subject_properties#</a>
	</li>

    </ul>

    <center>

      <if @can_instantiate@>
	<table cellpadding="5" width="95%">
	  <tr>
	    <td align="left">
	      <nobr>
		<small>[
		  <a href="class-instance-new?class_key=@class_key@">#dotlrn.new_class_instance#</a>
		  ]</small>
	      </nobr>
	    </td>
	  </tr>
	</table>

	<br>
      </if>
      <else>
	<include src="need-term-note">
      </else>

      <table bgcolor="#cccccc" cellpadding="5" width="95%">
	<tr bgcolor="#eeeeee">
	  <th align="left" width="50%">
	    <formtemplate id="term_form">
	      #dotlrn.term#:&nbsp;<formwidget id="term_id">
	    </formtemplate>
	  </th>
	</tr>
      </table>

      <br>

	  <form action="class" method="GET">
	    Search classes  with : 
	    <input name="keyword" onfocus="if(this.value=='Please type a keyword')this.value='';" onblur="if(this.value=='')this.value='Please type a keyword';" value="Please type a keyword" />
            <input type="hidden" name="class_key" value="@class_key@" />
            <input type="hidden" name="term_id" value="@term_id@" />
	    <input type="submit" value="Go" />
	  </form>

	<if @class_instances:rowcount@ gt 0>
	  <listtemplate name="class_instances"></listtemplate>

	</if>
	<else>
	  <table>
	    <tr bgcolor="#eeeeee">
	      <td align="left" colspan="4">
		<i>#dotlrn.no_class_instances#</i>
	      </td>
	    </tr>
	  </table>
	</else>

    </center>





