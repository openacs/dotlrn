<?xml version="1.0"?>

<queryset>

<fullquery name="select_dotlrn_users">
<querytext>
select first_names, last_name from dotlrn_users, registered_users where dotlrn_users.user_id= registered_users.user_id
</querytext>
</fullquery>

</queryset>
