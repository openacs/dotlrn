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
  <fullquery name="select_users">
    <querytext>
      select user_id,
             first_names,
             last_name,
             email
      from registered_users
      where lower(last_name) like lower('%' || :search_text || '%')
      or lower(email) like lower('%' || :search_text || '%')
    </querytext>
  </fullquery>
</queryset>
