<?xml version="1.0"?>

<queryset>

    <fullquery name="select_user_info">      
        <querytext>
            select first_names,
                   last_name,
                   email,
                   screen_name,
                   creation_date as registration_date,
                   creation_ip,
                   last_visit,
                   member_state,
                   email_verified_p
            from cc_users
            where user_id = :user_id
        </querytext>
    </fullquery>

    <fullquery name="select_direct_group_membership">
        <querytext>
            select group_id,
                   rel_id,
                   party_names.party_name as group_name
            from (select /*+ ORDERED */ distinct rels.rel_id,
                         object_id_one as group_id, 
                         object_id_two
                  from acs_rels rels, all_object_party_privilege_map perm
                  where perm.object_id = rels.rel_id
                  and perm.privilege = 'read'
                  and rels.rel_type = 'membership_rel'
                  and rels.object_id_two = :user_id) r, 
                 party_names 
            where r.group_id = party_names.party_id
            order by lower(party_names.party_name)
        </querytext> 
    </fullquery>

    <fullquery name="select_all_group_membership">
        <querytext>
            select groups.group_id,
                   groups.group_name
            from groups,
                 group_member_map gm
            where groups.group_id = gm.group_id
            and gm.member_id = :user_id
            order by lower(groups.group_name)
        </querytext>
    </fullquery>

</queryset>
