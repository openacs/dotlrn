
select define_function_args('dotlrn_privacy__guest_p','user_id');
select define_function_args('dotlrn_privacy__set_user_non_guest','user_id');
select define_function_args('dotlrn_privacy__set_user_guest,'user_id');
select define_function_args('dotlrn_privacy__grant_rd_prv_dt_for_rel','object_id,rel_type');
select define_function_args('dotlrn_privacy__revoke_rd_prv_dt_for_rel','object_id,rel_type');

--
-- provides extra checking to a simple view query, since Guest status is not
-- yet used uniformly across OACS.
--
create or replace function dotlrn_privacy__guest_p (integer)
returns char as '
declare
  v_user_id alias for $1;
  v_count integer;
  v_guest_p char(1);
begin
  select count(*) into v_count from dotlrn_guest_status where user_id = v_user_id;
  if v_count > 1 then
    raise EXCEPTION ''-20000: Guest status is multiply defined for user %'', v_user_id;
  end if;
  if v_count = 0 then
    raise EXCEPTION ''-20000: Guest status is not defined for user %'', v_user_id;
  end if;
  select guest_p into v_guest_p from dotlrn_guest_status where user_id = v_user_id;
  return v_guest_p;
end;' language 'plpgsql';

create or replace function dotlrn_privacy__set_user_non_guest (integer)
returns integer as '
declare
  v_user_id alias for $1;
  v_rel_id integer;
  cur record;
begin
  for cur in
    select r.rel_id 
      from acs_rels r, 
           membership_rels m 
      where m.rel_id = r.rel_id 
        and (r.rel_type = ''dotlrn_guest_rel''
             or r.rel_type = ''dotlrn_non_guest_rel'')
        and r.object_id_one = acs__magic_object_id(''registered_users'')
        and r.object_id_two = v_user_id
  loop 
    perform membership_rel__delete(cur.rel_id);
  end loop;
  v_rel_id := membership_rel__new(
    null,
    ''dotlrn_non_guest_rel'',
    acs__magic_object_id(''registered_users''),
    v_user_id,
    ''approved'',
    null,
    null
  );

  return 0;
end;' language 'plpgsql';

create or replace function dotlrn_privacy__set_user_guest (integer)
returns integer as '
declare
  v_user_id alias for $1;
  v_rel_id integer;
  cur record;
begin
  for cur in
    select r.rel_id 
      from acs_rels r, 
           membership_rels m 
      where m.rel_id = r.rel_id 
        and (r.rel_type = ''dotlrn_guest_rel''
             or r.rel_type = ''dotlrn_non_guest_rel'')
        and r.object_id_one = acs__magic_object_id(''registered_users'')
        and r.object_id_two = v_user_id
  loop 
    perform membership_rel__delete(cur.rel_id);
  end loop;
  v_rel_id := membership_rel__new(
    null,
    ''dotlrn_guest_rel'',
    acs__magic_object_id(''registered_users''),
    v_user_id,
    ''approved'',
    null,
    null
  );

  return 0;
end;' language 'plpgsql';

create or replace function dotlrn_privacy__grant_rd_prv_dt_for_rel (integer,varchar)
returns integer as '
declare
  v_object_id alias for $1;
  v_rel_type alias for $2;
  v_segment_id integer;
begin
  select segment_id into v_segment_id
  from rel_segments
  where group_id = acs__magic_object_id(''registered_users'')
    and rel_type = v_rel_type;
  perform acs_permission__grant_permission(v_object_id,v_segment_id,''read_private_data'');
  return 0;
end;' language 'plpgsql';

create or replace function dotlrn_privacy__revoke_rd_prv_dt_for_rel (integer,varchar)
returns integer as '
declare
  v_object_id alias for $1;
  v_rel_type alias for $2;
  v_segment_id integer;
begin
  select segment_id into v_segment_id
  from rel_segments
  where group_id = acs__magic_object_id(''registered_users'')
    and rel_type = v_rel_type;
  perform acs_permission__revoke_permission(v_object_id,v_segment_id,''read_private_data'');
  return 0;
end;' language 'plpgsql';

