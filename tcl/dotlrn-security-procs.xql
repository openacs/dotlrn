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

  <fullquery name="dotlrn::get_user_types.select_user_types">
    <querytext>
      select type
      from dotlrn_user_types
      order by pretty_name
    </querytext>
  </fullquery>

  <fullquery name="dotlrn::get_user_types_as_options.select_user_types_as_options">
    <querytext>
      select pretty_name,
             type
      from dotlrn_user_types
      order by pretty_name
    </querytext>
  </fullquery>

  <fullquery name="dotlrn::user_remove.select_rel_id">
    <querytext>
      select rel_id
      from dotlrn_users
      where user_id = :user_id
    </querytext>
  </fullquery>

  <fullquery name="dotlrn::user_get_type.select_user_type">
    <querytext>
      select type
      from dotlrn_users
      where user_id = :user_id
    </querytext>>
  </fullquery>

  <fullquery name="dotlrn::user_add.update_user_portal_id">
    <querytext>
      update dotlrn_full_user_profile_rels
      set portal_id = :portal_id
      where rel_id = (select rel_id
                      from dotlrn_full_users
                      where user_id = :user_id)
    </querytext>
  </fullquery>

</queryset>
