<%

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

%>

<master src="dotlrn-master">
<property name="title">@spam_name@</property>
<property name="context_bar">@context_bar@</property>

<p>
  Are you sure you want to send the following @spam_name@ Message?
</p>

  <table class="z_dark" bgcolor="#eeeeee" width="95%" cellpadding="3" cellspacing="3">
    <tr>
      <td width="10%">Subject</td>
      <td>@subject@</td>
    </tr>
    <tr>
      <td>Message</td>
      <td>        <%= [ad_text_to_html --  "$preview_message"] %></td>
    </tr>
  </table>

<form action="spam" method="post">
  @confirm_data@
  <input type="submit" value="Confirm"></input>
</form>
