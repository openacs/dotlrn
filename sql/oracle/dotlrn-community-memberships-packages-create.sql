
--
-- The DotLRN memberships packages
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started November 6th, 2001
--

--
-- Basic dotLRN membership rel
--

create or replace package dotlrn_member_rel
is
  function new (
    rel_id		in dotlrn_member_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_member_rel',
    page_id		in dotlrn_member_rels.page_id%TYPE default NULL,
    community_id	in dotlrn_communities.community_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_member_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_member_rels.rel_id%TYPE
  );

end;
/
show errors;


create or replace package body dotlrn_member_rel
is
  function new (
    rel_id		in dotlrn_member_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_member_rel',
    page_id		in dotlrn_member_rels.page_id%TYPE default NULL,
    community_id	in dotlrn_communities.community_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_member_rels.rel_id%TYPE
  is
    v_rel_id	membership_rels.rel_id%TYPE;
  begin
    v_rel_id:= membership_rel.new(rel_id => rel_id,
			rel_type => rel_type,
			object_id_one => community_id,
			object_id_two => user_id,
			creation_user => creation_user,
			creation_ip => creation_ip);

    insert into dotlrn_member_rels
    (rel_id, page_id) values
    (v_rel_id, page_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_member_rels.rel_id%TYPE
  )
  is 
  begin
    delete from dotlrn_member_rels where rel_id= dotlrn_member_rel.delete.rel_id;

    membership_rel.delete(rel_id);
  end;

end;
/
show errors;


--
-- dotLRN Admin rel
--

create or replace package dotlrn_admin_rel
is
  function new (
    rel_id		in dotlrn_admin_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_admin_rel',
    community_id	in dotlrn_communities.community_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    page_id		in dotlrn_member_rels.page_id%TYPE default null,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_admin_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_admin_rels.rel_id%TYPE
  );

end;
/
show errors;


create or replace package body dotlrn_admin_rel
is
  function new (
    rel_id		in dotlrn_admin_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_admin_rel',
    community_id	in dotlrn_communities.community_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    page_id		in dotlrn_member_rels.page_id%TYPE default null,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_admin_rels.rel_id%TYPE
  is
    v_rel_id	dotlrn_admin_rels.rel_id%TYPE;
  begin
    v_rel_id:= dotlrn_member_rel.new(rel_id => rel_id,
			rel_type => rel_type,
			community_id => community_id,
			user_id => user_id,
			page_id => page_id,
			creation_user => creation_user,
			creation_ip => creation_ip);

    insert into dotlrn_admin_rels
    (rel_id) values
    (v_rel_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_admin_rels.rel_id%TYPE
  )
  is 
  begin
    delete from dotlrn_admin_rels where rel_id= dotlrn_admin_rel.delete.rel_id;

    dotlrn_member_rel.delete(rel_id);
  end;

end;
/
show errors;


--
-- dotLRN Student rel
--

create or replace package dotlrn_student_rel
is
  function new (
    rel_id		in dotlrn_student_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_student_rel',
    page_id		in dotlrn_member_rels.page_id%TYPE default NULL,
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_student_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_student_rels.rel_id%TYPE
  );

end;
/
show errors;


create or replace package body dotlrn_student_rel
is
  function new (
    rel_id		in dotlrn_student_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_student_rel',
    page_id		in dotlrn_member_rels.page_id%TYPE default NULL,
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_student_rels.rel_id%TYPE
  is
    v_rel_id	dotlrn_student_rels.rel_id%TYPE;
  begin
    v_rel_id:= dotlrn_member_rel.new(rel_id => rel_id,
			rel_type => rel_type,
			page_id => page_id,
			community_id => class_instance_id,
			user_id => user_id,
			creation_user => creation_user,
			creation_ip => creation_ip);

    insert into dotlrn_student_rels
    (rel_id) values
    (v_rel_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_student_rels.rel_id%TYPE
  )
  is 
  begin
    delete from dotlrn_student_rels where rel_id= dotlrn_student_rel.delete.rel_id;

    dotlrn_member_rel.delete(rel_id);
  end;

end;
/
show errors;


--
-- dotLRN TA rel
--

create or replace package dotlrn_ta_rel
is
  function new (
    rel_id		in dotlrn_ta_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_ta_rel',
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    page_id		in dotlrn_member_rels.page_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_ta_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_ta_rels.rel_id%TYPE
  );

end;
/
show errors;


create or replace package body dotlrn_ta_rel
is
  function new (
    rel_id		in dotlrn_ta_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_ta_rel',
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    page_id		in dotlrn_member_rels.page_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_ta_rels.rel_id%TYPE
  is
    v_rel_id	dotlrn_ta_rels.rel_id%TYPE;
  begin
    v_rel_id:= dotlrn_admin_rel.new(rel_id => rel_id,
			rel_type => rel_type,
			community_id => class_instance_id,
			user_id => user_id,
			page_id => page_id,
			creation_user => creation_user,
			creation_ip => creation_ip);

    insert into dotlrn_ta_rels
    (rel_id) values
    (v_rel_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_ta_rels.rel_id%TYPE
  )
  is 
  begin
    delete from dotlrn_ta_rels where rel_id= dotlrn_ta_rel.delete.rel_id;

    dotlrn_admin_rel.delete(rel_id);
  end;

end;
/
show errors;


--
-- dotLRN Instructor rel
--

create or replace package dotlrn_instructor_rel
is
  function new (
    rel_id		in dotlrn_instructor_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_instructor_rel',
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    page_id		in dotlrn_member_rels.page_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_instructor_rels.rel_id%TYPE;

  procedure delete (
    rel_id		in dotlrn_instructor_rels.rel_id%TYPE
  );

end;
/
show errors;


create or replace package body dotlrn_instructor_rel
is
  function new (
    rel_id		in dotlrn_instructor_rels.rel_id%TYPE default NULL,
    rel_type		in acs_rels.rel_type%TYPE default 'dotlrn_instructor_rel',
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE,
    user_id		in dotlrn_users.user_id%TYPE,
    page_id		in dotlrn_member_rels.page_id%TYPE,
    creation_user	in acs_objects.creation_user%TYPE default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null
  ) return dotlrn_instructor_rels.rel_id%TYPE
  is
    v_rel_id	dotlrn_instructor_rels.rel_id%TYPE;
  begin
    v_rel_id:= dotlrn_admin_rel.new(rel_id => rel_id,
			rel_type => rel_type,
			community_id => class_instance_id,
			user_id => user_id,
			page_id => page_id,
			creation_user => creation_user,
			creation_ip => creation_ip);

    insert into dotlrn_instructor_rels
    (rel_id) values
    (v_rel_id);

    return v_rel_id;
  end;

  procedure delete (
    rel_id		in dotlrn_instructor_rels.rel_id%TYPE
  )
  is 
  begin
    delete from dotlrn_instructor_rels where rel_id= dotlrn_instructor_rel.delete.rel_id;

    dotlrn_admin_rel.delete(rel_id);
  end;

end;
/
show errors;



