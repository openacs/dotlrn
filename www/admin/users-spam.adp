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
<property name="title">Spam Users</property>
<property name="context_bar">@context_bar@</property>

<formtemplate id="spam_message"></formtemplate>

<blockquote>

  <table>

    <tr>
      <th colspan=3>The following variables can be used to insert user/community specific data:</th>
    </tr>

    <tr>
      <td>{from}</td>
      <td> = </td>
      <td>Sender's Email Address</td>
    </tr>

    <tr>
      <td>{email}</td>
      <td> = </td>
      <td>Recipient's Email</td>
    </tr>

    <tr>
      <td>{first_names}</td>
      <td> = </td>
      <td>Recipient's First Name</td>
    </tr>

    <tr>
      <td>{last_name}</td>
      <td> = </td>
      <td>Recipient's Last Name</td>
    </tr>

  </table>

</blockquote>
