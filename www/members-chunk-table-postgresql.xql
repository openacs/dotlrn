<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="select_current_members">
        <querytext>
            select dotlrn_member_rels_approved.rel_id,
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   dotlrn_member_rels_approved.user_id,
                   registered_users.first_names,
                   registered_users.last_name,
                   registered_users.email
            from registered_users,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.community_id = :community_id
            and dotlrn_member_rels_approved.user_id = registered_users.user_id
            order by (
                CASE 
                    WHEN role = 'instructor'
                    THEN 1
                    WHEN role = 'admin'
                    THEN 2
                    WHEN role = 'teaching_assistant'
                    THEN 3
                    WHEN role = 'course_assistant'
                    THEN 4
                    WHEN role = 'student'
                    THEN 6
                    WHEN role = 'member'
                    THEN 7
                END
            ) asc, $order_by
        </querytext>
    </fullquery>

</queryset>
