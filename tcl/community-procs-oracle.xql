<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="dotlrn_community::new_type.create_community_type">
<querytext>
declare
begin
	
:1 := dotlrn_community_type.new (
	community_type => :community_type,
	parent_type => :supertype,
	pretty_name => :pretty_name,
	pretty_plural => :pretty_name,
	description => :description
);

end;
</querytext>
</fullquery>


<fullquery name="dotlrn_community::new.create_community">
<querytext>
declare
begin
	
:1 := dotlrn_community.new (
	community_type => :community_type,
	community_key => :name
	pretty_name => :pretty_name,
	pretty_plural => :pretty_name,
	description => :description
);

end;
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_url.select_node_url">
<querytext>
select site_node.url(node_id) from site_nodes where parent_id= :current_node_id and object_id= :package_id
</querytext>
</fullquery>

<fullquery name="dotlrn_community::get_community_type_from_community_id.select_community_type">
<querytext>
select object_type from acs_object_types where supertype='dotlrn_community' start with object_type = (select community_type from dotlrn_communities where community_id=:community_id) connect by object_type= prior supertype 
</querytext>
</fullquery>

</queryset>
