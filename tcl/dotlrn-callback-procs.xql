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

</queryset>
