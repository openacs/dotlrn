<%

    #
    #  Copyright (C) 2001, 2002 OpenForce, Inc.
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
<property name="title">@title@</property>
<property name="show_control_panel">1</property>
<property name="link_control_panel">1</property>

Are you sure you want to <strong>ARCHIVE</strong> group <strong>@pretty_name@</strong>?
<p>
This will not delete the group's data, but the group will only be able to be 
accessed by Site Wide Admins.
<br>

<formtemplate id="archive_subcomm"></formtemplate>
