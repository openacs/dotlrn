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

@first_names@ @last_name@ has been added to @system_name@.
Edit the message below and hit "Send Email" to
notify this user.

<p></p>

<form method="post" action="user-add-3">
  @export_vars@
  Message:

  <p></p>

  <textarea name="message" rows="10" cols="70" wrap="hard">
@first_names@ @last_name@,

You have been added as a user to @system_name@
at @system_url@

Login information:
Email: @email@
Password: @password@
(you may change your password after you log in)

Thank you,
@administration_name@
  </textarea>

  <p></p>

  <input type="submit" value="Send Email">
</form>
