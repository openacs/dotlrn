<?xml version="1.0"?>

<queryset>

<fullquery name="dotlrn_community::new_type.create_community_type">
<querytext>
declare
begin
end;
</querytext>
</fullquery>


<fullquery name="dotlrn_community::set_type_package_id.update_package_id">
<querytext>
update dotlrn_community_types set package_id= :package_id where community_type= :community_type
</querytext>
</fullquery>


<fullquery name="dotlrn_community::new">
<querytext>
insert into dotlrn_communities
(community_id, community_type, community_key, pretty_name, description)
values
(:community_id, :community_type, :name, :pretty_name, :description)
</querytext>
</fullquery>

<fullquery name="dotlrn_community::set_package_id.update_package_id">
<querytext>
update dotlrn_communities set package_id= :package_id where community_id= :community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::list_users.select_users">
<querytext>
select rel_id, users.user_id, first_names, last_name, email from registered_users users, dotlrn_community_memberships 
where community_id= :community_id and users.user_id = dotlrn_community_memberships.user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::member_p.select_count_membership">
<querytext>
select count(*) from dotlrn_community_memberships where community_id= :community_id and user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::add_user.insert_membership">
<querytext>
insert into dotlrn_community_memberships 
(rel_id, community_id, user_id, page_id)
values
(:rel_id, :community_id, :user_id, :page_id)
</querytext>
</fullquery>

<fullquery name="dotlrn_community::remove_user.select_rel_info">
<querytext>
select rel_id, page_id from dotlrn_community_memberships where community_id= :community_id and user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::remove_user.delete_membership">
<querytext>
delete from dotlrn_community_memberships where rel_id=:rel_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_page_id.select_page_id">
<querytext>
select page_id from dotlrn_community_memberships where community_id= :community_id and user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_communities_by_user.select_communities">
<querytext>
select dotlrn_communities.community_id as community_id, community_type, pretty_name, description, package_id
from dotlrn_communities, dotlrn_community_memberships
where community_type= :community_type
and user_id= :user_id
and dotlrn_communities.community_id = dotlrn_community_memberships.community_id
</querytext>
</fullquery>
\
<fullquery name="dotlrn_community::get_active_communities.select_active_communities">
<querytext>
select community_id, community_type, pretty_name, description, package_id
from dotlrn_communities
where community_type= :community_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_type.select_community_type">
<querytext>
select community_type from dotlrn_community_types where package_id= :package_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_id.select_community">
<querytext>
select community_id from dotlrn_communities where package_id= :package_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_package_id.select_package_id">
<querytext>
select package_id from dotlrn_communities where community_id= :community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::add_applet.insert_applet">
<querytext>
insert into dotlrn_community_applets
(community_id, applet_key)
values
(:community_id, :applet_key)
</querytext>
</fullquery>

<fullquery name="dotlrn_community::remove_applet.delete_applet">
<querytext>
delete from dotlrn_community_applets where
community_id= :community_id and applet_key= :applet_key
</querytext>
</fullquery>

<fullquery name="dotlrn_community::list_applets.select_all_applets">
<querytext>
select impl_name from acs_sc_impls, acs_sc_bindings, acs_sc_contracts
where
acs_sc_impls.impl_id = acs_sc_bindings.impl_id and
acs_sc_contracts.contract_id= acs_sc_bindings.contract_id and 
acs_sc_contracts.contract_name='dotlrn_applet'
</querytext>
</fullquery>

<fullquery name="dotlrn_community::list_applets.select_community_applets">
<querytext>
select applet_key from dotlrn_community_applets where community_id= :community_id
</querytext>
</fullquery>

</queryset>
