<?xml version="1.0"?>

<queryset>
    <fullquery name="select_current_members">
        <querytext>
            select dotlrn_member_rels_approved.rel_id,
                   dotlrn_member_rels_approved.rel_type,
                   dotlrn_member_rels_approved.role,
                   dotlrn_member_rels_approved.user_id,
                   acs_users_all.first_names,
                   acs_users_all.last_name,
                   acs_users_all.email,
                   (select count(*) from acs_rels where rel_type = 'user_portrait_rel' and object_id_one = dotlrn_member_rels_approved.user_id) as portrait_p,
                   (select count(*) from acs_attribute_values where object_id = dotlrn_member_rels_approved.user_id and attribute_id = :bio_attribute_id and attr_value != '') as bio_p
            from acs_users_all,
                 dotlrn_member_rels_approved
            where dotlrn_member_rels_approved.community_id = :community_id
            and dotlrn_member_rels_approved.user_id = acs_users_all.user_id
	    $orderby
        </querytext>
    </fullquery>
</queryset>