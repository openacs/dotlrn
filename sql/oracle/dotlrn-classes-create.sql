
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started August 18th, 2001
--

create table dotlrn_classes (
       class_key		    constraint dotlrn_class_class_key_fk
				    references dotlrn_community_types(community_type)
				    constraint dotlrn_class_class_key_pk
				    primary key
);

create table dotlrn_class_instances (
       class_instance_id	    constraint dotlrn_class_i_id_fk
				    references dotlrn_communities(community_id)
				    constraint dotlrn_class_i_id_pk
				    primary key,
       class_key		    constraint dotlrn_class_i_class_key_fk
				    references dotlrn_classes(class_key),
       year			    varchar(10),
       term			    varchar(20)
);



-- 
-- PL/SQL stuff
--

create or replace package dotlrn_class
is
 function new (
   class_key		in dotlrn_classes.class_key%TYPE,
   pretty_name		in dotlrn_communities.pretty_name%TYPE,
   pretty_plural	in dotlrn_community_types.pretty_name%TYPE default null,
   description		in dotlrn_community_types.description%TYPE,
   package_id		in dotlrn_community_types.package_id%TYPE default null,
   creation_date        in acs_objects.creation_date%TYPE
                           default sysdate,
   creation_user        in acs_objects.creation_user%TYPE
                           default null,
   creation_ip          in acs_objects.creation_ip%TYPE default null,
   context_id		in acs_objects.context_id%TYPE default null
 ) return dotlrn_classes.class_key%TYPE;

 procedure delete (
   class_key		in dotlrn_classes.class_key%TYPE
 );

end;
/
show errors



create or replace package body dotlrn_class
is
 function new (
   class_key		in dotlrn_classes.class_key%TYPE,
   pretty_name		in dotlrn_communities.pretty_name%TYPE,
   pretty_plural	in dotlrn_community_types.pretty_name%TYPE default null,
   description		in dotlrn_community_types.description%TYPE,
   package_id		in dotlrn_community_types.package_id%TYPE default null,
   creation_date        in acs_objects.creation_date%TYPE
                           default sysdate,
   creation_user        in acs_objects.creation_user%TYPE
                           default null,
   creation_ip          in acs_objects.creation_ip%TYPE default null,
   context_id		in acs_objects.context_id%TYPE default null
 ) return dotlrn_classes.class_key%TYPE
 is
   v_class_key dotlrn_classes.class_key%TYPE;
 begin
   v_class_key := dotlrn_community_type.new (
	community_type => class_key,
	parent_type => 'dotlrn_class',
	pretty_name => pretty_name,
	pretty_plural => pretty_plural,
	description => description,
	package_id => package_id,
	creation_date => creation_date,
	creation_user => creation_user,
	creation_ip => creation_ip,
	context_id => context_id
   );

   insert into dotlrn_classes
   (class_key) values (v_class_key);

   return v_class_key;
 end;

 procedure delete (
   class_key		in dotlrn_classes.class_key%TYPE
 )
 is
 begin
   delete from dotlrn_classes where class_key = class_key;

   dotlrn_community_type.delete(class_key);
 end;

end;
/
show errors


create or replace package dotlrn_class_instance
is
  function new (
    class_instance_id		in dotlrn_class_instances.class_instance_id%TYPE,
    class_key			in dotlrn_class_instances.class_key%TYPE,
    year			in dotlrn_class_instances.year%TYPE,
    term			in dotlrn_class_instances.term%TYPE,
    community_key		in dotlrn_communities.community_key%TYPE,
    pretty_name		in dotlrn_communities.pretty_name%TYPE,
    description		in dotlrn_communities.description%TYPE,
    package_id			in dotlrn_communities.package_id%TYPE default null,
    creation_date		in acs_objects.creation_date%TYPE
			   default sysdate,
    creation_user		in acs_objects.creation_user%TYPE
			   default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null,
    context_id			in acs_objects.context_id%TYPE default null
  ) return dotlrn_class_instances.class_instance_id%TYPE;

  procedure delete (
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE
  ); 
end;
/
show errors


create or replace package body dotlrn_class_instance
is
  function new (
    class_instance_id		in dotlrn_class_instances.class_instance_id%TYPE default null,
    class_key			in dotlrn_class_instances.class_key%TYPE,
    year			in dotlrn_class_instances.year%TYPE,
    term			in dotlrn_class_instances.term%TYPE,
    community_key		in dotlrn_communities.community_key%TYPE,
    pretty_name		in dotlrn_communities.pretty_name%TYPE,
    description		in dotlrn_communities.description%TYPE,
    package_id			in dotlrn_communities.package_id%TYPE default null,
    creation_date		in acs_objects.creation_date%TYPE
			   default sysdate,
    creation_user		in acs_objects.creation_user%TYPE
			   default null,
    creation_ip		in acs_objects.creation_ip%TYPE default null,
    context_id			in acs_objects.context_id%TYPE default null
  ) return dotlrn_class_instances.class_instance_id%TYPE
  is
    v_class_instance_id dotlrn_class_instances.class_instance_id%TYPE;
  begin
    v_class_instance_id := dotlrn_community.new (
	community_id => class_instance_id,
	community_type => class_key,
	community_key => community_key,
	pretty_name => pretty_name,
	description => description,
	package_id => package_id,
	creation_date => creation_date,
	creation_user => creation_user,
	creation_ip => creation_ip,
	context_id => context_id
    );

    insert into dotlrn_class_instances
    (class_instance_id, class_key, year, term)
    values
    (v_class_instance_id, class_key, year, term);
  
    return v_class_instance_id;
  end;

  procedure delete (
    class_instance_id	in dotlrn_class_instances.class_instance_id%TYPE
  )
  is
  begin
    delete from dotlrn_class_instances
    where class_instance_id= class_instance_id;

    dotlrn_community.delete(community_id => class_instance_id);
  end;

end;
/
show errors
