<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn::get_user_types.select_user_types">
<querytext>
select type, type_id from dotlrn_user_types order by type
</querytext>
</fullquery>

<fullquery name="dotlrn::user_remove.select_rel_id">
<querytext>
select rel_id from dotlrn_users where user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn::user_get_type.select_user_type">
<querytext>
select type from dotlrn_users, dotlrn_user_types where dotlrn_user_rels.type_id= dotlrn_user_types.type_id and user_id= :user_id
</querytext>>
</fullquery>

<fullquery name="dotlrn::user_add.update_user_portal_id">
<querytext>
update dotlrn_full_user_rels set portal_id= :portal_id where rel_id = (select rel_id from dotlrn_full_users where user_id= :user_id)
</querytext>
</fullquery>

</queryset>
