<?xml version="1.0"?>

<queryset>

    <fullquery name="select_dotlrn_users_count">
        <querytext>
            select count(*)
            from dotlrn_users
            where dotlrn_users.type = :type
        </querytext>
    </fullquery>

    <fullquery name="select_non_dotlrn_users_count">
        <querytext>
            select count(*)
            from (select acs_rels.object_id_two
                  from acs_rels, membership_rels
                  where acs_rels.object_id_one = :registered_users_id
                  and acs_rels.rel_id = membership_rels.rel_id
                  and membership_rels.member_state
                      not in ('banned','deleted','rejected')
                  and acs_rels.object_id_two not in (                  
                      select acs_rels.object_id_two
                             from acs_rels,
                             dotlrn_user_types
                       where acs_rels.object_id_one = dotlrn_user_types.group_id)) as foo
        </querytext>
    </fullquery>

    <fullquery name="select_deactivated_users_count">
        <querytext>
            select count(*)
            from persons,
                 acs_rels,
                 membership_rels
            where acs_rels.object_id_one = :registered_users_id
            and acs_rels.object_id_two = persons.person_id
            and acs_rels.rel_id = membership_rels.rel_id
            and membership_rels.member_state = 'banned'
        </querytext>
    </fullquery>
    
</queryset>
