<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="select_user_info">
<querytext>
select first_names, last_name, email, type_id, case when dotlrn_full_user_rels.rel_id is NULL then 't' else 'f' end as limited_access_p, acs_permission.permission_p(:dotlrn_package_id, user_id, 'read_private_data') as read_private_data_p from dotlrn_users, dotlrn_full_user_rels where user_id=:user_id and dotlrn_users.rel_id= dotlrn_full_user_rels.rel_id(+)
</querytext>
</fullquery>

</queryset>
