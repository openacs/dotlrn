<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="dotlrn_privacy::set_user_guest_p.set_user_non_guest">
        <querytext>
            declare
              v_rel_id integer;
            begin
              for cur in (select r.rel_id from acs_rels r, 
                                 membership_rels m 
                          where m.rel_id = r.rel_id 
                            and (r.rel_type = 'dotlrn_guest_rel' 
                                 or r.rel_type = 'dotlrn_non_guest_rel')
                            and r.object_id_one = acs.magic_object_id('registered_users')
                            and r.object_id_two = :user_id)
              loop 
                membership_rel.del(cur.rel_id);
              end loop;
              v_rel_id := membership_rel.new(
                rel_type => 'dotlrn_non_guest_rel',
                object_id_one => acs.magic_object_id('registered_users'),
                object_id_two => :user_id,
                member_state => 'approved'
              );
            end;
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_privacy::set_user_guest_p.set_user_guest">
        <querytext>
            declare
              v_rel_id integer;
            begin
              for cur in (select r.rel_id from acs_rels r,
                          membership_rels m
                          where m.rel_id = r.rel_id
                            and (r.rel_type = 'dotlrn_guest_rel'
                                 or r.rel_type = 'dotlrn_non_guest_rel')
                            and r.object_id_one = acs.magic_object_id('registered_users')
                            and r.object_id_two = :user_id)
              loop 
                membership_rel.del(cur.rel_id);
              end loop;
              v_rel_id := membership_rel.new(
                rel_type => 'dotlrn_guest_rel',
                object_id_one => acs.magic_object_id('registered_users'),
                object_id_two => :user_id,
                member_state => 'approved'
              );
            end;
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_privacy::set_read_private_data_for_rel.set_read_private_data_for_rel">
        <querytext>
            declare
              v_segment_id integer;
            begin
              select segment_id into v_segment_id
              from rel_segments
              where group_id = acs.magic_object_id('registered_users')
                and rel_type = :rel_type;
              acs_permission.${action}_permission(:object_id,v_segment_id,'read_private_data');
            end;
        </querytext>
    </fullquery>

    <fullquery name="dotlrn_privacy::guests_can_view_private_data_p.guests_granted_read_private_data_p">
        <querytext>
            select case when count(1) = 0 then 0 else 1 end
        from acs_permissions p,
             rel_segments r
        where p.grantee_id = r.segment_id
          and p.privilege = 'read_private_data'
          and r.group_id = acs.magic_object_id('registered_users')
          and r.rel_type = 'dotlrn_guest_rel'
          and p.object_id = :object_id
        </querytext>
    </fullquery>

</queryset>
