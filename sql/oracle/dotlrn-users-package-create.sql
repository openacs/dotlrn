
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- October 30th, 2001
-- we remember September 11th, 2001
--

--
-- Users of the dotLRN system
--

create or replace package dotlrn_user_rel
is
  function new (
    rel_id		in dotlrn_user_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_user_rel',
    type_id		in dotlrn_user_rels.type_id%TYPE,
    group_id		in groups.group_id%TYPE default NULL,
    user_id		in users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_user_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_user_rels.rel_id%TYPE
  );

end;
/
show errors


create or replace package body dotlrn_user_rel
is
  function new (
    rel_id		in dotlrn_user_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_user_rel',
    type_id		in dotlrn_user_rels.type_id%TYPE,
    group_id		in groups.group_id%TYPE default NULL,
    user_id		in users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_user_rels.rel_id%TYPE
  is
    v_rel_id		membership_rels.rel_id%TYPE;
    p_group_id		groups.group_id%TYPE;
  begin
    if group_id is NULL then
       p_group_id:= dotlrn_get_group_id();
    else 
       p_group_id:= group_id;
    end if;

    v_rel_id:= membership_rel.new (
		rel_id => rel_id,
		rel_type => rel_type,
		object_id_one => p_group_id,
		object_id_two => user_id,
		creation_user => creation_user,
		creation_ip => creation_ip);

    insert into dotlrn_user_rels
    (rel_id, type_id) values
    (v_rel_id, type_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_user_rels.rel_id%TYPE
  )
  is
  begin
    delete from dotlrn_user_rels where rel_id= dotlrn_user_rel.delete.rel_id;

    membership_rel.delete(rel_id);
  end;

end;
/
show errors



--
-- Full Users
--

create or replace package dotlrn_full_user_rel
is
  function new (
    rel_id		in dotlrn_full_user_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_full_user_rel',
    type_id		in dotlrn_user_rels.type_id%TYPE,
    portal_id		in dotlrn_full_user_rels.portal_id%TYPE,
    group_id		in groups.group_id%TYPE default NULL,
    user_id		in users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_full_user_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_full_user_rels.rel_id%TYPE
  );

end;
/
show errors


create or replace package body dotlrn_full_user_rel
is
  function new (
    rel_id		in dotlrn_full_user_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_full_user_rel',
    type_id		in dotlrn_user_rels.type_id%TYPE,    
    portal_id		in dotlrn_full_user_rels.portal_id%TYPE,
    group_id		in groups.group_id%TYPE default NULL,
    user_id		in users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_full_user_rels.rel_id%TYPE
  is
    v_rel_id		dotlrn_user_rels.rel_id%TYPE;
  begin
    v_rel_id:= dotlrn_user_rel.new (
		rel_id => rel_id,
		rel_type => rel_type,
		type_id => type_id,
		group_id => group_id,
		user_id => user_id,
		creation_user => creation_user,
		creation_ip => creation_ip);

    insert into dotlrn_full_user_rels
    (rel_id, portal_id) values
    (v_rel_id, portal_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_full_user_rels.rel_id%TYPE
  )
  is
  begin
    delete from dotlrn_full_user_rels where rel_id = dotlrn_full_user_rel.delete.rel_id;

    dotlrn_user_rel.delete(rel_id);
  end;

end;
/
show errors

