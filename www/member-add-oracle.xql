<?xml version="1.0"?>

<queryset>

	<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="select_users">
        <querytext>
            select a.user_id, a.first_names, a.last_name, a.email,
                   case when b.user_id is not null then 1 else 0 end as member_p 
            from dotlrn_users a 
            left outer join (select user_id from dotlrn_member_rels_full where community_id = :community_id) b 
                         on (a.user_id = b.user_id)
            where lower(a.last_name) like lower('%' || :search_text || '%')
               or lower(a.first_names) like lower('%' || :search_text || '%')
               or lower(a.email) like lower('%' || :search_text || '%')
        </querytext>
    </fullquery>

</queryset>
