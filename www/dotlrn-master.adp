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

<master>

<!-- A list of all the properties that pages in dotlrn _may_ set, passing them
     up to the dotlrn-default-master -->


<if @title@ defined>
  <property name="title">@title@</property>
</if>

<if @link_all@ defined>
  <property name="link_all">@link_all@</property>
</if>

<if @return_url@ defined>
  <property name="return_url">@return_url@</property>
</if>

<if @show_control_panel@ defined>
  <property name="show_control_panel">@show_control_panel@</property>
</if>

<if @link_control_panel@ defined>
  <property name="link_control_panel">@link_control_panel@</property>
</if>

<if @no_navbar_p@ defined>
  <property name="no_navbar_p">@no_navbar_p@</property>
</if>

<if @portal_id@ defined>
  <property name="portal_id">@portal_id@</property>
</if>

<slave>
