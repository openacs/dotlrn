<?xml version="1.0"?>

<queryset>
  <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="sender_info">
        <querytext>
        select '$from' as from_addr,
               '[db_quote $sender_first_names]' as sender_first_names,
               '[db_quote $sender_last_name]' as sender_last_name,
               parties.email,
               decode(acs_objects.object_type,
                      'user',
                      (select first_names
                       from persons
                       where person_id = parties.party_id),
                      'group',
                      (select group_name
                       from groups
                       where group_id = parties.party_id),
                      'rel_segment',
                      (select segment_name
                       from rel_segments
                       where segment_id = parties.party_id),
                      '') as first_names,
               decode(acs_objects.object_type,
                      'user',
                      (select last_name
                       from persons
                       where person_id = parties.party_id),
                      '') as last_name,
               '$safe_community_name' as community_name,
               '$community_url' as community_url
            from acs_rels,
                 parties,
                 acs_objects
            where (acs_rels.object_id_one = $community_id
            and acs_rels.object_id_two = parties.party_id
            and (acs_rels.rel_type in ($rel_types_str)
	         or acs_rels.object_id_two in ($recipients_str))
	    and parties.party_id = acs_objects.object_id
            and parties.party_id in (select acs_rels.object_id_two  
                                     from acs_rels, membership_rels
                                     where acs_rels.object_id_one = 
                                        acs.magic_object_id('registered_users')
                                     and acs_rels.rel_id = 
                                        membership_rels.rel_id
                                     and membership_rels.member_state 
                                        = 'approved')) 
        </querytext>
    </fullquery>

</queryset>
