
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
