--
-- Privacy control
-- by aegrumet@alum.mit.edu on 2004-02-10
--
--
-- dotLRN supports a method of protecting private information about
-- individuals.  This code is intended to help comply with privacy laws such
-- as the US -- Family Educational Right to Privacy Act aka the
-- "Buckley Amendment"
--
--     http://www.cpsr.org/cpsr/privacy/ssn/ferpa.buckley.html
--
-- Here we set up the structures for assigning a site-wide flag to
-- each user that indicates whether or not they are "guest" users.  In
-- the context of dotlrn, guest users do not by default have access to
-- private information such as the names of students taking a
-- particular class.
--
create function inline_1()
returns integer as '
declare
    v_guest_segment_id integer;
    v_non_guest_segment_id integer;
    v_object_id integer;
begin

    --
    -- Guests
    --

    perform acs_rel_type__create_type(
        ''dotlrn_guest_rel'',
        ''.LRN Guest'',
        ''.LRN Guests'',
        ''membership_rel'',
        ''dotlrn_guest_rels'',
        ''rel_id'',
        ''dotlrn_guest_rel'',
        ''group'',
        null,
        0,
        null,
        ''user'',
        null,
        0,
        1
    );

    v_guest_segment_id := rel_segment__new(
        ''Registered .LRN Guests'',
        acs__magic_object_id(''registered_users''),
        ''dotlrn_guest_rel''
    );

    --
    -- Non Guests
    --

    perform acs_rel_type__create_type(
        ''dotlrn_non_guest_rel'',
        ''.LRN Non-Guest'',
        ''.LRN Non-Guests'',
        ''membership_rel'',
        ''dotlrn_non_guest_rels'',
        ''rel_id'',
        ''dotlrn_non_guest_rel'',
        ''group'',
        null,
        0,
        null,
        ''user'',
        null,
        0,
        1
    );

    v_non_guest_segment_id := rel_segment__new(
        ''Registered .LRN Non-Guests'',
        acs__magic_object_id(''registered_users''),
        ''dotlrn_non_guest_rel''
    );

    return(0);
end;
' language 'plpgsql';

select inline_1();
drop function inline_1();

create or replace view dotlrn_guest_status
as
select r.object_id_two as user_id,
       case when r.rel_type = 'dotlrn_guest_rel' then 't' else 'f' end as guest_p
  from acs_rels r, 
       membership_rels m 
where m.rel_id = r.rel_id 
  and (r.rel_type = 'dotlrn_guest_rel' 
       or r.rel_type = 'dotlrn_non_guest_rel')
  and r.object_id_one = acs__magic_object_id('registered_users');

--
-- Provides extra checking to a simple view query, since Guest status is not
-- yet used uniformly across OACS.
--
create or replace function dotlrn_guest_p (integer)
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

