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

<fullquery name="dotlrn_community::set_package_id.update_package_id">
<querytext>
update dotlrn_communities set package_id= :package_id where community_id= :community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_rel_segment_id.select_rel_segment_id">
<querytext>
select segment_id from rel_segments where group_id= :community_id and rel_type= :rel_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::list_users.select_users">
<querytext>
select rel_id, rel_type, users.user_id, first_names, last_name, email from registered_users users, dotlrn_member_rels_full where community_id= :community_id and users.user_id = dotlrn_member_rels_full.user_id order by rel_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::member_p.select_count_membership">
<querytext>
select count(*) from dotlrn_member_rels_full where community_id= :community_id and user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::remove_user.select_rel_info">
<querytext>
select rel_id, page_id from dotlrn_member_rels_full where community_id= :community_id and user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_page_id.select_page_id">
<querytext>
select page_id from dotlrn_member_rels_full where community_id= :community_id and user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_workspace_page_id.select_user_page_id">
<querytext>
select page_id from dotlrn_users where user_id= :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_non_members_page_id.select_community_page_id">
<querytext>
select page_id from dotlrn_communities where community_id= :community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_all_communities_by_user.select_communities_by_user">
<querytext>
select dotlrn_communities.community_id, community_type, community_key, pretty_name from dotlrn_communities, dotlrn_member_rels_full where dotlrn_communities.community_id = dotlrn_member_rels_full.community_id and dotlrn_member_rels_full.user_id = :user_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_communities_by_user.select_communities">
<querytext>
select dotlrn_communities.community_id as community_id, community_type, pretty_name, description, package_id
from dotlrn_communities, dotlrn_member_rels_full
where community_type= :community_type
and user_id= :user_id
and dotlrn_communities.community_id = dotlrn_member_rels_full.community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_active_communities.select_active_communities">
<querytext>
select community_id, community_type, pretty_name, description, package_id
from dotlrn_communities
where community_type= :community_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_all_communities.select_all_communities">
<querytext>
select community_id, community_type, pretty_name, description, package_id, community_key
from dotlrn_communities
where community_type= :community_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_type.select_community_type">
<querytext>
select community_type from dotlrn_community_types where package_id= :package_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_type_from_community_id.select_community_type">
<querytext>
select community_type from dotlrn_communities where community_id=:community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_id.select_community">
<querytext>
select community_id from dotlrn_communities where package_id= :package_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_type_package_id.select_package_id">
<querytext>
select package_id from dotlrn_community_types where community_type= :community_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_package_id.select_package_id">
<querytext>
select package_id from dotlrn_communities where community_id= :community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_applet_package_id.select_package_id">
<querytext>
select package_id from dotlrn_community_applets where community_id= :community_id and applet_key= :applet_key
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_type_name.select_community_type_name">
<querytext>
select pretty_name from dotlrn_community_types where community_type= :community_type
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_name.select_community_name">
<querytext>
select pretty_name from dotlrn_communities where community_id= :community_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_portal_template_id.select_portal_template_id">
<querytext>
select portal_template_id from dotlrn_communities where community_id= :community_id
</querytext>
</fullquery>


<fullquery name="dotlrn_community::add_applet.insert_applet">
<querytext>
insert into dotlrn_community_applets
(community_id, applet_key, package_id)
values
(:community_id, :applet_key, :package_id)
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
