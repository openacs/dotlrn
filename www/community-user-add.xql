<?xml version="1.0"?>

<queryset>

<fullquery name="select_users">
<querytext>
select user_id, first_names, last_name, email from dotlrn_full_users where lower(last_name) like lower('%' || :search_text || '%') or lower(email) like lower('%' || :search_text || '%') and user_id not in (select user_id from dotlrn_member_rels_full where community_id= :community_id)
</querytext>
</fullquery>

</queryset>
