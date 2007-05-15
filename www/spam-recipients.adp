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

<master>
<property name="title">@spam_name@</property>
<property name="context">@context_bar@</property>

<h1>#dotlrn.Choose_members_to_receive#</h1>

<form method="post" action="spam">

<input type=checkbox name=spam_all> #dotlrn.Send_to_all#
<p>
#dotlrn.Send_to_the_following_roles# <p>
@rel_types_html;noquote@

@exported_vars;noquote@
<p><input type=submit value="#dotlrn.Compose_bulk_message#"></p>
#dotlrn.Send_to_the_following_members#:<p>
</form>

<listtemplate name="current_members"></listtemplate>




