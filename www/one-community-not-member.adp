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

<-- this should be removed b/c we have the non-member portal now -->

<master src="dotlrn-master">
<property name="context_bar">@context_bar@</property>
<property name="pretext">@pretext@</property>

<property name="show_control_panel">@admin_p@</property>

<if @admin_p@ eq 0>
  <property name="no_navbar_p">1</property>
</if>

@rendered_page@
