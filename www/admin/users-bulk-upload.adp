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
<property name="title">Users: Bulk Upload</property>
<property name="context_bar">@context_bar@</property>

Here you can create several users at once using a correctly formatted CSV
(comma-separated values) file. You can create a spreadsheet and save it as
a CSV file to import here.

<p>

<strong>Be sure</strong> to use vaild email addresses since the process
will send the new user's password to the given email address.

</p>


<div style="font-size: large; font-weight: bold;">CSV File Format</div>

<p style="text-indent: 1em">
  
  <strong>First Line</strong>

  <p style="text-indent: 2em">
  
    The first line of the file <em>must</em> be the header line:
    
    <div style="text-indent: 3em; font-family: monospace">
      first_names,last_name,email,id,type,access_level,guest
    </div>
   
  </p>

</p>

<p style="text-indent: 1em">

  <strong>Fields</strong>
  
  <ul>
    <li><tt>first_names</tt> - <em>required</em>
    <li><tt>last_name</tt> - <em>required</em>
    <li><tt>email</tt> - <em>required</em>
    <li><tt>id</tt> - <em>optional, defaults to email</em> - 
        a secondary identifier for the  user.
    <li><tt>type</tt> - <em>required</em> - must be one of 
      <ul>
        <li>professor
        <li>student
        <li>admin
        <li>external
      </ul>
    <li><tt>access_level</tt> - <em>optional, defaults to full</em> - 
        <em>must</em> be either <tt>full</tt> or <tt>limited</tt>
    <li><tt>guest</tt> - <em>optional, defaults to guest</em> -
        <em>must</em> be either <tt>t</tt> or <tt>f</tt>
  </ul>
  
</p>

<p style="text-indent: 1em">

  <strong>Example File</strong>
  
  <pre>
    first_names,last_name,email,id,type,access_level,guest
    Joe,Student,joe@_somewhere_.net,123-456-7890,student,full,f
    Albert,Einstein,al@_school_.edu,al,professor,full,f
    Systems,Hacker,syshacker@_company_.com,,admin,,,
    Intersted,Onlooker,onlooker@_somewhere_.net,,external,,limited,t
  </pre>
  
</p>

<p style="text-indent: 1em">

Note: you will have the option of adding these users to a group
once they have been uploaded.

</p>

<div style="padding-left: 1em">

  <FORM enctype=multipart/form-data method=post action=users-bulk-upload-2>
  <INPUT TYPE=file name=users_csv_file>
  <br>
  <br>
  <INPUT TYPE=submit value=upload>
  </FORM>
</div>
