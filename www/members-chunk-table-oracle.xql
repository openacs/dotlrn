<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_current_members">
        <querytext>
            select dotlrn_member_rels_approved.rel_id,
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   dotlrn_member_rels_approved.user_id,
                   acs_users_all.first_names,
                   acs_users_all.last_name,
                   acs_users_all.email
            from acs_users_all,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.community_id = :community_id
            and dotlrn_member_rels_approved.user_id = 
	    acs_users_all.user_id order by decode(role,
                            'instructor',1,
                            'admin',2,
                            'teaching_assistant',3,
                            'course_assistant',4,
                            'course_admin',5,
                            'student',6,
                            'member',7), $order_by
            
        </querytext>
    </fullquery>

</queryset>
