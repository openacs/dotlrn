<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn::user_get_role.select_user_role">
<querytext>
select role from dotlrn_users where user_id = :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn::user_add.update_user_page_id">
<querytext>
update dotlrn_users set page_id= :page_id
</querytext>
</fullquery>

<fullquery name="dotlrn::user_remove.remove_user">
<querytext>
dotlrn_user.remove(:user_id)
</querytext>
</fullquery>

</queryset>
