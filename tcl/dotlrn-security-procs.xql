<?xml version="1.0"?>

<queryset>

  <fullquery name="dotlrn::get_user_types.select_user_types">
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
