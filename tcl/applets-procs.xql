<?xml version="1.0"?>
<!--

  Copyright (C) 2001, 2002 OpenForce, Inc.

  This file is part of dotLRN.

  dotLRN is free software; you can redistribute it and/or modify it under the
  terms of the GNU General Public License as published by the Free Software
  Foundation; either version 2 of the License, or (at your option) any later
  version.

  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

-->


<queryset>

    <fullquery name="dotlrn_applet::applet_exists_p.select_applet_exists_p">
        <querytext>
            select count(*)
            from dual
            where exists (select 1
                          from dotlrn_applets
                          where dotlrn_applets.applet_key = :applet_key)
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_applet::get_applet_id_from_key.select">
        <querytext>
            select applet_id
            from dotlrn_applets
            where applet_key = :applet_key
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_applet::add_applet_to_dotlrn.insert">
        <querytext>
            insert
            into dotlrn_applets
            (applet_id, applet_key, status)
            values
            (:applet_id, :applet_key, :status)
        </querytext>
    </fullquery>

</queryset>
