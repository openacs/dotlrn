
--
-- The DotLRN communities membership constructs
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started November 6th, 2001
--


create table dotlrn_member_rels (
       rel_id				  integer not null
					  constraint dlrn_mem_fk references acs_rels(rel_id)
					  constraint dlrn_mem_pk primary key,
       page_id				  integer
					  constraint dlrn_mem_page_id_fk references portals(portal_id)
);					  

create view dotlrn_member_rels_full as select acs_rels.rel_id as rel_id, object_id_one as community_id, object_id_two as user_id, rel_type, page_id from dotlrn_member_rels, acs_rels where dotlrn_member_rels.rel_id = acs_rels.rel_id;

create table dotlrn_admin_rels (
       rel_id			      integer not null
				      constraint dlrn_adm_fk references dotlrn_member_rels(rel_id)
				      constraint dlrn_adm_pk primary key
);

create view dotlrn_admin_rels_full as select acs_rels.rel_id as rel_id, object_id_one as community_id, object_id_two as user_id, rel_type, page_id from dotlrn_member_rels, dotlrn_admin_rels, acs_rels where dotlrn_member_rels.rel_id = acs_rels.rel_id and dotlrn_admin_rels.rel_id= acs_rels.rel_id;


--
-- For Classes
--

create table dotlrn_student_rels (
       rel_id			 integer not null
				 constraint dlrn_stud_fk references dotlrn_member_rels(rel_id)
				 constraint dlrn_stud_pk primary key
);

create view dotlrn_student_rels_full as select acs_rels.rel_id as rel_id, object_id_one as community_id, object_id_two as user_id, rel_type from dotlrn_student_rels, acs_rels where dotlrn_student_rels.rel_id = acs_rels.rel_id;


create table dotlrn_ta_rels (
       rel_id		    integer not null
			    constraint dlrn_ta_fk references dotlrn_admin_rels(rel_id)
			    constraint dlrn_ta_pk primary key
);

create view dotlrn_ta_rels_full as select acs_rels.rel_id as rel_id, object_id_two as community_id, object_id_two as user_id, rel_type from dotlrn_ta_rels, acs_rels where dotlrn_ta_rels.rel_id = acs_rels.rel_id;


create table dotlrn_instructor_rels (
       rel_id			    integer not null
				    constraint dlrn_instruct_fk references dotlrn_admin_rels(rel_id)
				    constraint dlrn_instruct_pk primary key
);

create view dotlrn_instructor_rels_full as select acs_rels.rel_id as rel_id, object_id_two as community_id, object_id_two as user_id, rel_type from dotlrn_instructor_rels, acs_rels where dotlrn_instructor_rels.rel_id = acs_rels.rel_id;


--
-- Object Types and Attributes
--

declare
	foo	integer;
begin
	acs_rel_type.create_type (
	   rel_type => 'dotlrn_member_rel',
	   supertype => 'membership_rel',
	   pretty_name => 'dotLRN Membership',
	   pretty_plural => 'dotLRN Memberships',
	   package_name => 'dotlrn_member_rel',
	   table_name => 'dotlrn_member_rels',	
	   id_column => 'rel_id',
	   object_type_one => 'dotlrn_community', role_one => NULL, 
	   min_n_rels_one => 0, max_n_rels_one => NULL,
	   object_type_two => 'dotlrn_user', role_two => NULL,
	   min_n_rels_two => 0, max_n_rels_two => NULL
	);

	acs_rel_type.create_type (
	   rel_type => 'dotlrn_admin_rel',
	   supertype => 'dotlrn_member_rel',
	   pretty_name => 'dotLRN Admin Membership',
	   pretty_plural => 'dotLRN Admin Memberships',
	   package_name => 'dotlrn_admin_rel',
	   table_name => 'dotlrn_admin_rels',	
	   id_column => 'rel_id',
	   object_type_one => 'dotlrn_community', role_one => NULL, 
	   min_n_rels_one => 0, max_n_rels_one => NULL,
	   object_type_two => 'dotlrn_user', role_two => NULL,
	   min_n_rels_two => 0, max_n_rels_two => NULL
	);

	acs_rel_type.create_type (
	   rel_type => 'dotlrn_student_rel',
	   supertype => 'dotlrn_member_rel',
	   pretty_name => 'dotLRN Student Membership',
	   pretty_plural => 'dotLRN Student Memberships',
	   package_name => 'dotlrn_student_rel',
	   table_name => 'dotlrn_student_rels',	
	   id_column => 'rel_id',
	   object_type_one => 'dotlrn_class', role_one => NULL, 
	   min_n_rels_one => 0, max_n_rels_one => NULL,
	   object_type_two => 'dotlrn_user', role_two => NULL,
	   min_n_rels_two => 0, max_n_rels_two => NULL
	);

	acs_rel_type.create_type (
	   rel_type => 'dotlrn_ta_rel',
	   supertype => 'dotlrn_admin_rel',
	   pretty_name => 'dotLRN TA Membership',
	   pretty_plural => 'dotLRN TA Memberships',
	   package_name => 'dotlrn_ta_rel',
	   table_name => 'dotlrn_ta_rels',	
	   id_column => 'rel_id',
	   object_type_one => 'dotlrn_class', role_one => NULL, 
	   min_n_rels_one => 0, max_n_rels_one => NULL,
	   object_type_two => 'dotlrn_user', role_two => NULL,
	   min_n_rels_two => 0, max_n_rels_two => NULL
	);

	acs_rel_type.create_type (
	   rel_type => 'dotlrn_instructor_rel',
	   supertype => 'dotlrn_admin_rel',
	   pretty_name => 'dotLRN Instructor Membership',
	   pretty_plural => 'dotLRN Instructor Memberships',
	   package_name => 'dotlrn_instructor_rel',
	   table_name => 'dotlrn_instructor_rels',	
	   id_column => 'rel_id',
	   object_type_one => 'dotlrn_class', role_one => NULL, 
	   min_n_rels_one => 0, max_n_rels_one => NULL,
	   object_type_two => 'dotlrn_user', role_two => NULL,
	   min_n_rels_two => 0, max_n_rels_two => NULL
	);

	--
	-- and now for the attributes
	--
	foo:= acs_attribute.create_attribute (
	      object_type => 'dotlrn_member_rel',
	      attribute_name => 'page_id',
	      datatype => 'integer',
	      pretty_name => 'Page ID',
	      pretty_plural => 'Page IDs'
	);

end;
/
show errors
