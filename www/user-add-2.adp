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
<property name="title">#dotlrn.Add_A_User#</property>
<property name="context_bar">@context_bar@</property>

@first_names@ @last_name@ #dotlrn.has_been_added_to# @system_name@.
#dotlrn.edit_message_and_hit_send#

<p></p>

<form method="post" action="user-add-3">
  @export_vars@
  #dotlrn.Message#

  <p></p>

  <textarea name="message" rows="10" cols="70" wrap="hard">
@first_names@ @last_name@,

#dotlrn.you_have_been_added# @system_name@
#dotlrn.at# @system_url@

#dotlrn.login_information#
#dotlrn.email# @email@
#dotlrn.password# @password@
(#dotlrn.you_may_change_password#)

#dotlrn.thank_you#,
@administration_name@
  </textarea>

  <p></p>

  <input type="submit" value="#dotlrn.send_email#">
</form>




