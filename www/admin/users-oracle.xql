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
            from cc_users
            where not exists (select 1
                              from dotlrn_users
                              where dotlrn_users.user_id = cc_users.user_id)
            and member_state = 'approved'
        </querytext>
    </fullquery>

    <fullquery name="select_deactivated_users_count">
        <querytext>
            select count(*)
            from cc_users
            where member_state = 'banned'
        </querytext>
    </fullquery>

</queryset>
