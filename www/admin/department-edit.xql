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

    <fullquery name="select_department_info">
        <querytext>
            select pretty_name,
                   description,
                   external_url
            from dotlrn_departments_full
            where department_key = :department_key
        </querytext>
    </fullquery>

    <fullquery name="update_department">
        <querytext>
            update dotlrn_departments
            set external_url = :external_url
            where department_key = :department_key
        </querytext>
    </fullquery>

    <fullquery name="update_community_type">
        <querytext>
            update dotlrn_community_types
            set pretty_name = :pretty_name,
                description = :description
            where community_type = :department_key
        </querytext>
    </fullquery>

</queryset>
