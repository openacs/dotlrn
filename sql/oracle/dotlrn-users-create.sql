
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

-- not an object, there's really no use for it
-- this is just so other, non-university systems can set up their own user types
create table dotlrn_user_types (
       type_id		       integer not null
			       constraint dlrn_user_type_pk primary key,
       type		       varchar(200) not null
			       constraint dlrn_user_type_un unique
);

create table dotlrn_user_rels (
       rel_id		      integer not null
			      constraint dlrn_user_rel_fk references membership_rels(rel_id)
			      constraint dlrn_user_rel_pk primary key,
       type_id		      integer not null
			      constraint dlrn_user_rel_type_fk references dotlrn_user_types(type_id)
);

create table dotlrn_full_user_rels (
       rel_id			   integer not null
				   constraint dlrn_full_user_rel_fk references dotlrn_user_rels(rel_id)
				   constraint dlrn_full_user_rel_pk primary key,
       theme_id			   integer
				   constraint dlrn_full_user_theme_fk references portal_element_themes(theme_id),
       portal_id		   integer not null
				   constraint dlrn_full_user_portal_fk references portals(portal_id)
);

-- the user group
declare
	foo integer;
begin
	foo:= acs_group.new (
		group_id => NULL,
		object_type => 'group',
		creation_date => sysdate,
		group_name => 'dotLRN Users'
	);
end;
/
show errors


create or replace function dotlrn_get_group_id return integer is
        p_group_id	   integer;
begin
	select max(group_id) into p_group_id from groups where group_name= 'dotLRN Users';

	return p_group_id;
end;
/
show errors

create view dotlrn_users as select acs_rels.rel_id, registered_users.user_id, first_names, last_name, email, type
from dotlrn_user_rels, acs_rels, registered_users, dotlrn_user_types where 
acs_rels.object_id_two = registered_users.user_id and
acs_rels.object_id_one = dotlrn_get_group_id() and
acs_rels.rel_id = dotlrn_user_rels.rel_id and
dotlrn_user_rels.type_id= dotlrn_user_types.type_id;

create view dotlrn_full_users as select acs_rels.rel_id, registered_users.user_id, first_names, last_name, email, type, portal_id, theme_id
from dotlrn_user_rels, dotlrn_full_user_rels, acs_rels, registered_users, dotlrn_user_types where 
acs_rels.object_id_two = registered_users.user_id and
acs_rels.object_id_one = dotlrn_get_group_id() and
acs_rels.rel_id = dotlrn_user_rels.rel_id and
dotlrn_user_rels.rel_id = dotlrn_full_user_rels.rel_id and
dotlrn_user_types.type_id = dotlrn_user_rels.type_id;

-- The packages

declare
	v_group_id integer;
	foo integer;
begin
   acs_rel_type.create_type (
	rel_type => 'dotlrn_user_rel',
	supertype => 'membership_rel',
	pretty_name => 'dotLRN User Membership',
	pretty_plural => 'dotLRN User Memberships',
	package_name => 'dotlrn_user_rel',
	table_name => 'dotlrn_user_rels',
	id_column => 'rel_id',
	object_type_one => 'group', role_one => NULL, min_n_rels_one => 0, max_n_rels_one => NULL,
	object_type_two => 'user', role_two => NULL, min_n_rels_two => 0, max_n_rels_two => 1
   );

   acs_rel_type.create_type (
	rel_type => 'dotlrn_full_user_rel',
	supertype => 'dotlrn_user_rel',
	pretty_name => 'dotLRN Full User Membership',
	pretty_plural => 'dotLRN Full User Memberships',
	package_name => 'dotlrn_full_user_rel',
	table_name => 'dotlrn_full_user_rels',
	id_column => 'rel_id',
	object_type_one => 'group', role_one => NULL, min_n_rels_one => 0, max_n_rels_one => NULL,
	object_type_two => 'user', role_two => NULL, min_n_rels_two => 0, max_n_rels_two => 1
   );

   v_group_id:= dotlrn_get_group_id();

   -- Now we create the rel segments!
   foo:= rel_segment.new (
	segment_name => 'dotLRN Users',
	group_id => v_group_id,
	rel_type => 'dotlrn_user_rel'
   );

   foo:= rel_segment.new (
	segment_name => 'dotLRN Full Access Users',
	group_id => v_group_id,
	rel_type => 'dotlrn_full_user_rel'
   );

end;
/
show errors

