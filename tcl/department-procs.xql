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
  <fullquery name="dotlrn_department::new.insert_department">
    <querytext>
      insert into dotlrn_departments
      (department_key, external_url)
      values
      (:department_key, :external_url)
    </querytext>
  </fullquery>

  <fullquery name="dotlrn_department::check_department_key_valid_p.check">
    <querytext>
      select 1 from dotlrn_departments where department_key = :department_key
    </querytext>
  </fullquery>

  <fullquery name="dotlrn_department::select_as_list.select_departments">
    <querytext>
      select pretty_name,
             department_key
      from dotlrn_departments_full
      order by pretty_name
    </querytext>
  </fullquery>
</queryset>
