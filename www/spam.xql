<?xml version="1.0"?>

<queryset>

      <fullquery name="sender_info">
        <querytext>
        select parties.email,
               CASE
                  WHEN
                      acs_objects.object_type = 'user'
                  THEN
                      (select first_names
                       from persons
                       where person_id = parties.party_id)
                  WHEN
                      acs_objects.object_type = 'group'
                  THEN
                      (select group_name
                       from groups
                       where group_id = parties.party_id)
                  WHEN
                      acs_objects.object_type = 'rel_segment'
                  THEN
                      (select segment_name
                       from rel_segments
                       where segment_id = parties.party_id)
                  ELSE
                      ''
               END as first_names,
               CASE
                  WHEN
                     acs_objects.object_type = 'user'
                  THEN
                      (select last_name
                       from persons
                       where person_id = parties.party_id)
                  ELSE 
                      ''
               END as last_name
            from acs_rels,
                 parties,
                 acs_objects
            where (acs_rels.object_id_one = $community_id
            and acs_rels.object_id_two = parties.party_id
            and parties.party_id = acs_objects.object_id
            and parties.party_id in (select acs_rels.object_id_two  
                                     from acs_rels, membership_rels
                                     where acs_rels.object_id_one = [ns_dbquotevalue $registered_users_id]
                                     and acs_rels.rel_id = membership_rels.rel_id
                                     and membership_rels.member_state = 'approved' ))
	    $who_will_receive_this_clause
        </querytext>
    </fullquery>

    <partialquery name="recipients_clause">
      <querytext>
          and parties.party_id in ($recipients_str)
      </querytext>
    </partialquery>

    <partialquery name="rel_types_clause">
      <querytext>
          and acs_rels.rel_type in ($rel_types_str)
      </querytext>
    </partialquery>

</queryset>
