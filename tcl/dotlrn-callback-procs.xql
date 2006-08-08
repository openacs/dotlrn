<?xml version="1.0"?>

<queryset>

    <fullquery name="callback::MergePackageUser::impl::dotlrn.get_from_rel_ids">
        <querytext>	
        select rel_id, rel_type, object_id_one
	from acs_rels 
	where object_id_two = :from_user_id
	and object_id_one not in (select object_id_one 
	                          from acs_rels 
	                          where object_id_two = :to_user_id )
        </querytext>
    </fullquery>

    <fullquery name="callback::MergeShowUserInfo::impl::dotlrn.get_from_rel_ids">
        <querytext>	
        select rel_id, rel_type, object_id_one
	from acs_rels 
	where object_id_two = :user_id
        </querytext>
    </fullquery>

    <fullquery name="callback::contact::person_new::impl::dotlrn_user.get_community_id">
        <querytext>	

	select c.community_id 
	  from acs_rels r, dotlrn_communities c 
         where r.object_id_one = :contact_id 
         and r.object_id_two = c.community_id

        </querytext>
    </fullquery>


</queryset>
