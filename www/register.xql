<?xml version="1.0"?>

<queryset>

    <fullquery name="select_join_policy">
        <querytext>
	   select join_policy
	   from dotlrn_communities_full
	   where community_id = :community_id
        </querytext>
    </fullquery>

    <fullquery name="select_admin_rel_segment_id">
        <querytext>
            select rel_segments.segment_id
            from rel_segments
            where rel_segments.group_id = :community_id
            and rel_segments.rel_type = 'dotlrn_admin_rel'
        </querytext>
    </fullquery>

    <partialquery name="bulk_mail_query">
        <querytext>

            select parties.email,
                   case acs_objects.object_type
                   when 'user' then 
                      (select first_names
                      from persons
                      where person_id = parties.party_id)
                   when 'group' then 
                     (select group_name
                      from groups
                      where group_id = parties.party_id)
                   when 'rel_segment' then
                     (select segment_name
                      from rel_segments
                      where segment_id = parties.party_id)
                   else ''
                   end as first_names,
                   case acs_objects.object_type
                   when 'user' then 
                     (select last_name
                      from persons
                      where person_id = parties.party_id)
                   else ''
                   end  as last_name
            from   party_approved_member_map,
                   parties,
                   acs_objects
            where  party_approved_member_map.party_id = :segment_id
            and    party_approved_member_map.member_id <> :segment_id
            and    party_approved_member_map.member_id = parties.party_id
            and    parties.party_id = acs_objects.object_id

        </querytext>
    </partialquery>
    
</queryset>
