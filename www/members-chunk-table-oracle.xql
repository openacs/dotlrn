<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

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
            order by decode(role,'instructor',1,'admin',2,'teaching_assistant',3,'course_assistant',4,'course_admin',5,'student',6,'member',7)
                     last_name
            -- note, last_name should be sorted by $order, but b/c this
            -- query gets called by ad_table, ad_table would have to know
            -- to uplevel order.. not going to happen.  So no reversals on 
            -- last name for now, sorry.
        </querytext>
    </fullquery>

</queryset>
