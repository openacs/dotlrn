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
<property name="title">#dotlrn.Users_Bulk_Upload#</property>
<property name="context_bar">@context_bar@</property>

#dotlrn.lt_Here_you_can_create_s#

<p>

<strong>#dotlrn.Be_sure#</strong> #dotlrn.lt_to_use_vaild_email_ad#

</p>


<div style="font-size: large; font-weight: bold;">#dotlrn.CSV_File_Format#</div>

<p style="text-indent: 1em">
  
  <strong>#dotlrn.First_Line#</strong>

  <p style="text-indent: 2em">
  
    #dotlrn.first_line_of_file_must_be#
    
    <div style="text-indent: 3em; font-family: monospace">
      first_names,last_name,email,id,type,access_level,guest
    </div>
   
  </p>

</p>

<p style="text-indent: 1em">

  <strong>#dotlrn.Fields#</strong>
  
  <ul>
    <li><tt>first_names</tt> - <em>#dotlrn.required#</em>
    <li><tt>last_name</tt> - <em>#dotlrn.required#</em>
    <li><tt>email</tt> - <em>#dotlrn.required#</em>
    <li><tt>id</tt> - <em>#dotlrn.optional_defaults_to# email</em> #dotlrn.lt_a_secondary#
    <li><tt>type</tt> - <em>#dotlrn.required#</em> #dotlrn.must_have_values# 
      <ul>
        <li>professor
        <li>student
        <li>admin
        <li>external
      </ul>
    <li><tt>access_level</tt> - <em>#dotlrn.optional_defaults_to# full</em> - 
        <em>#dotlrn.must_have_values#</em> <tt>full</tt>, <tt>limited</tt>
    <li><tt>guest</tt> - <em>#dotlrn.optional_defaults_to# guest</em> -
        <em>#dotlrn.must_have_values#</em> <tt>t</tt>, <tt>f</tt>
  </ul>
  
</p>

<p style="text-indent: 1em">

  <strong>#dotlrn.Example_File#</strong>
  
  <pre>
    first_names,last_name,email,id,type,access_level,guest
    Joe,Student,joe@_somewhere_.net,123-456-7890,student,full,f
    Albert,Einstein,al@_school_.edu,al,professor,full,f
    Systems,Hacker,syshacker@_company_.com,,admin,,,
    Intersted,Onlooker,onlooker@_somewhere_.net,,external,,limited,t
  </pre>
  
</p>

<p style="text-indent: 1em">

#dotlrn.lt_Note_you_will_have_th#

</p>

<div style="padding-left: 1em">

  <FORM enctype=multipart/form-data method=post action=users-bulk-upload-2>
  <INPUT TYPE=file name=users_csv_file>
  <br>
  <br>
  <INPUT TYPE=submit value="#dotlrn.upload#">
  </FORM>
</div>




