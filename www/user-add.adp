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

<master src="dotlrn-master">
<property name="title">Add A User</property>
<property name="context_bar">@context_bar@</property>
<h3>Add a new user to SloanSpace</h3>
<if @community_p@ eq 1>
<blockquote>
 Note: use this feature responsibly and <i>think</i> first.
<ol>
	<li>If this person is a MIT or Sloan Student have him self-register at sloanspace.mit.edu so he will have a full access account.
	<li> Be sure that the person does not already have a SloanSpace account under another email address. Duplicate accounts cause problems for everyone. To add a person with an existing account use <a href=members>Manage Membership</a>.

<if @read_private_data_p@ eq t>
	<li>Use this only for an officially registered student in this class who is <b>not</b> a MIT or Sloan student.

</if>
<else>
      <li>This allows you to give a non-MIT  person who is not a registered student access to this group.
      </li>
<ul>        
<li>Information about other members of this community will not be available to this user.
<li>If you wish to give guests full access to forums and surveys you may request that the site-wide admin change the status of your community. This option is not open to classes due to MIT privacy policy.
</else>      
</ul>
</ol>
</blockquote>
</if>
<center>
<formtemplate id="add_user"></formtemplate>
</center>