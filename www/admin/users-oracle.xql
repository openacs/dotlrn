<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

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
            from acs_rels
            where acs_rels.object_id_one = acs.magic_object_id('registered_users')
            and not exists (select 1
                            from acs_rels a, dotlrn_user_types
                            where a.object_id_one = dotlrn_user_types.group_id
                            and a.object_id_two = acs_rels.object_id_two)
        </querytext>
    </fullquery>

    <fullquery name="select_deactivated_users_count">
        <querytext>
            select count(*)
            from cc_users
            where cc_users.member_state = 'banned'
        </querytext>
    </fullquery>

</queryset>
