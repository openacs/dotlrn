
--
-- The DotLRN communities construct
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started September 20th, 2001 (redone)
--

create table dotlrn_community_types (
       community_type		    not null
				    constraint dlrn_comm_type_pk primary key
				    constraint dlrn_comm_type_fk
				    references group_types (group_type),
       pretty_name		    varchar(100) not null,
       description		    varchar(4000),
       package_id		    constraint dlrn_comm_type_pack_id_fk
				    references apm_packages(package_id),
       supertype		    constraint dlrn_comm_supertype_fk
				    references dotlrn_community_types(community_type)
);
       

create table dotlrn_communities (
       community_id		not null
				constraint dlrn_comm_id_pk primary key
				constraint dlrn_comm_id_fk
				references groups(group_id),
       community_type		not null
				constraint dlrn_comm_id_type_fk
				references dotlrn_community_types(community_type),
       community_key		varchar(100) not null
				constraint dlrn_comm_key_un unique,
       pretty_name		varchar(100) not null,
       description		varchar(4000),
       active_start_date	date,
       active_end_date		date,
       portal_id			references portals(portal_id),
       portal_template_id	references portals(portal_id),
       package_id		constraint dlrn_comm_pack_id_fk
				references apm_packages(package_id)
);

-- active communities
create view dotlrn_active_comms
as
    select dotlrn_communities.*,
           join_policy
    from dotlrn_communities,
         groups
    where (active_start_date is null or active_start_date < sysdate)
    and (active_end_date is null or active_end_date > sysdate)
    and dotlrn_communities.community_id = groups.group_id;

create view dotlrn_active_not_closed_comms
as
    select dotlrn_communities.*,
           join_policy
    from dotlrn_communities,
         groups
    where (active_start_date is null or active_start_date < sysdate)
    and (active_end_date is null or active_end_date > sysdate)
    and dotlrn_communities.community_id = groups.group_id
    and join_policy <> 'closed';

create table dotlrn_community_applets (
       community_id		      integer not null
				      constraint dlrn_comm_appl_comm_id_fk references dotlrn_communities(community_id),
       applet_key		      varchar(100) not null,
       constraint dlrn_comm_appl_pk primary key (community_id, applet_key),
       package_id		      integer, -- this is the package_id for what packge this applet represents
       active_p			      char(1) default 't' not null
				      constraint dlrn_comm_appl_act_p_ch check (active_p in ('t','f'))
);


-- 
-- PL/SQL for community and community types
--

create or replace package dotlrn_community_type
is
 function new (
   community_type	in dotlrn_community_types.community_type%TYPE,
   parent_type	in dotlrn_community_types.supertype%TYPE default 'dotlrn_community',
   pretty_name		in dotlrn_community_types.pretty_name%TYPE,
   pretty_plural	in dotlrn_community_types.pretty_name%TYPE default null,
   description		in dotlrn_community_types.description%TYPE,
   package_id		in dotlrn_community_types.package_id%TYPE default null,
   creation_date        in acs_objects.creation_date%TYPE
                           default sysdate,
   creation_user        in acs_objects.creation_user%TYPE
                           default null,
   creation_ip          in acs_objects.creation_ip%TYPE default null,
   context_id		in acs_objects.context_id%TYPE default null
 ) return dotlrn_community_types.community_type%TYPE;

 procedure delete (
   community_type	in dotlrn_community_types.community_type%TYPE
 );

 function name (
   community_type	in dotlrn_community_types.community_type%TYPE
 ) return varchar;

end;
/
show errors


create or replace package body dotlrn_community_type
is
 function new (
   community_type	in dotlrn_community_types.community_type%TYPE,
   parent_type		in dotlrn_community_types.supertype%TYPE default 'dotlrn_community', 
   pretty_name		in dotlrn_community_types.pretty_name%TYPE,
   pretty_plural	in dotlrn_community_types.pretty_name%TYPE default null,
   description		in dotlrn_community_types.description%TYPE,
   package_id		in dotlrn_community_types.package_id%TYPE default null,
   creation_date        in acs_objects.creation_date%TYPE
                           default sysdate,
   creation_user        in acs_objects.creation_user%TYPE
                           default null,
   creation_ip          in acs_objects.creation_ip%TYPE default null,
   context_id		in acs_objects.context_id%TYPE default null
 ) return dotlrn_community_types.community_type%TYPE
 is
   v_parent_object_type acs_object_types.object_type%TYPE;
 begin
   if parent_type is null
   then v_parent_object_type:= 'group';
   else v_parent_object_type:= parent_type;
   end if;

   acs_object_type.create_type (
	    supertype => v_parent_object_type,
	    object_type => community_type,
	    pretty_name => pretty_name,
	    pretty_plural => pretty_plural,
	    table_name => community_type,
	    id_column => 'XXX',
	    package_name => community_type,
	    name_method => 'acs_group.name'
   );

   insert into group_types
   (group_type, default_join_policy) values (community_type, 'closed');

   insert into dotlrn_community_types
   (community_type, pretty_name, description, package_id, supertype)
   values
   (community_type, pretty_name, description, package_id, parent_type);

   return community_type;
 end;

 procedure delete (
   community_type	in dotlrn_community_types.community_type%TYPE
 )
 is
 begin
   delete from dotlrn_community_types where community_type= community_type;

   acs_object_type.drop_type(community_type);
 end;

 function name (
   community_type	in dotlrn_community_types.community_type%TYPE
 ) return varchar
 is
   name dotlrn_community_types.pretty_name%TYPE;
 begin
   select pretty_name into name from dotlrn_community_types;

   return name;
 end;

end;
/
show errors


create or replace package dotlrn_community
is
 function new (
   community_id		in dotlrn_communities.community_id%TYPE default null,
   community_type	in dotlrn_communities.community_type%TYPE,
   community_key	in dotlrn_communities.community_key%TYPE,
   pretty_name		in dotlrn_communities.pretty_name%TYPE,
   description		in dotlrn_communities.description%TYPE,
   portal_id		in dotlrn_communities.portal_id%TYPE default null,
   portal_template_id	in dotlrn_communities.portal_template_id%TYPE default null,
   package_id		in dotlrn_communities.package_id%TYPE default null,
   creation_date        in acs_objects.creation_date%TYPE
                           default sysdate,
   creation_user        in acs_objects.creation_user%TYPE
                           default null,
   creation_ip          in acs_objects.creation_ip%TYPE default null,
   context_id		in acs_objects.context_id%TYPE default null
 ) return dotlrn_communities.community_id%TYPE;

 procedure set_active_dates (
   community_id		    in dotlrn_communities.community_id%TYPE,
   start_date		    in dotlrn_communities.active_start_date%TYPE,
   end_date		    in dotlrn_communities.active_end_date%TYPE
 );

 procedure delete (
   community_id		in dotlrn_communities.community_id%TYPE
 );

 function name (
   community_id		in dotlrn_communities.community_id%TYPE
 ) return varchar; 

 function member_p (
   community_id	in dotlrn_communities.community_id%TYPE,
   party_id		in parties.party_id%TYPE
 ) return char;

end dotlrn_community;
/
show errors


create or replace package body dotlrn_community
as
 function new (
   community_id		in dotlrn_communities.community_id%TYPE default null,
   community_type	in dotlrn_communities.community_type%TYPE,
   community_key	in dotlrn_communities.community_key%TYPE,
   pretty_name		in dotlrn_communities.pretty_name%TYPE,
   description		in dotlrn_communities.description%TYPE,
   portal_id		in dotlrn_communities.portal_id%TYPE default null,
   portal_template_id	in dotlrn_communities.portal_template_id%TYPE default null,
   package_id		in dotlrn_communities.package_id%TYPE default null,
   creation_date        in acs_objects.creation_date%TYPE
                           default sysdate,
   creation_user        in acs_objects.creation_user%TYPE
                           default null,
   creation_ip          in acs_objects.creation_ip%TYPE default null,
   context_id		in acs_objects.context_id%TYPE default null
 ) return dotlrn_communities.community_id%TYPE
 is
   c_id integer;
 begin
   c_id := acs_group.new (
	group_id => community_id,
	object_type => community_type,
	creation_date => creation_date,
	creation_user => creation_user,
	creation_ip => creation_ip,
	group_name => community_key
   );

   insert into dotlrn_communities
   (community_id, community_type, community_key, pretty_name, description, package_id, portal_id, portal_template_id)
   values
   (c_id, community_type, community_key, pretty_name, description, package_id, portal_id, portal_template_id);



   return c_id;
 end;

 procedure set_active_dates (
   community_id		    in dotlrn_communities.community_id%TYPE,
   start_date		    in dotlrn_communities.active_start_date%TYPE,
   end_date		    in dotlrn_communities.active_end_date%TYPE
 )
 is
 begin
   update dotlrn_communities set 
   active_start_date= start_date,
   active_end_date= end_date
   where
   community_id = set_active_dates.community_id;
 end;

 procedure delete (
   community_id		in dotlrn_communities.community_id%TYPE
 )
 is
 begin
   delete from dotlrn_communities where community_id= community_id;

   acs_group.delete(community_id);
 end;

 function name (
   community_id		in dotlrn_communities.community_id%TYPE
 ) return varchar
 is
 begin
   return acs_group.name(community_id);
 end;

 function member_p (
   community_id	in dotlrn_communities.community_id%TYPE,
   party_id		in parties.party_id%TYPE
 ) return char
 is
 begin
   -- TODO: a-la aD, implement this for real (bma)
   return 't';
 end;

end;
/
show errors
 

