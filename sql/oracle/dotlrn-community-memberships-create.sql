
--
-- The DotLRN communities membership constructs
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @creation-date  November 6th, 2001
-- @version $Id$
--

create table dotlrn_member_rels (
    rel_id                      constraint dotlrn_member_rels_rel_id_fk
                                references membership_rels (rel_id)
                                constraint dotlrn_member_rels_rel_id_pk
                                primary key,
    portal_id                   constraint dotlrn_member_rels_portal_fk
                                references portals (portal_id)
);                                          

create or replace view dotlrn_member_rels_full
as
    select acs_rels.rel_id as rel_id,
           object_id_one as community_id,
           object_id_two as user_id,
           rel_type,
           portal_id
    from dotlrn_member_rels,
         acs_rels
    where dotlrn_member_rels.rel_id = acs_rels.rel_id;

create table dotlrn_admin_rels (
    rel_id                      constraint dotlrn_admin_rels_rel_id_fk
                                references dotlrn_member_rels (rel_id)
                                constraint dotlrn_admin_rels_rel_id_pk
                                primary key
);

create or replace view dotlrn_admin_rels_full
as
    select acs_rels.rel_id as rel_id,
           acs_rels.object_id_one as community_id,
           acs_rels.object_id_two as user_id,
           acs_rels.rel_type,
           dotlrn_member_rels.portal_id
    from dotlrn_member_rels,
         dotlrn_admin_rels,
         acs_rels
    where dotlrn_member_rels.rel_id = acs_rels.rel_id
    and dotlrn_admin_rels.rel_id = acs_rels.rel_id;

--
-- For Classes
--

create table dotlrn_student_rels (
    rel_id                      constraint dotlrn_student_rels_rel_id_fk
                                references dotlrn_member_rels (rel_id)
                                constraint dotlrn_student_rels_rel_id_pk
                                primary key
);

create or replace view dotlrn_student_rels_full
as
    select acs_rels.rel_id as rel_id,
           acs_rels.object_id_one as community_id,
           acs_rels.object_id_two as user_id,
           acs_rels.rel_type
    from dotlrn_student_rels,
         acs_rels
    where dotlrn_student_rels.rel_id = acs_rels.rel_id;

create table dotlrn_ta_rels (
    rel_id                      constraint dotlrn_ta_rels_rel_id_fk
                                references dotlrn_admin_rels (rel_id)
                                constraint dotlrn_ta_rels_rel_id_pk
                                primary key
);

create or replace view dotlrn_ta_rels_full
as
    select acs_rels.rel_id as rel_id,
           acs_rels.object_id_one as community_id,
           acs_rels.object_id_two as user_id,
           acs_rels.rel_type
    from dotlrn_ta_rels,
         acs_rels
    where dotlrn_ta_rels.rel_id = acs_rels.rel_id;

create table dotlrn_ca_rels (
    rel_id                      constraint dotlrn_ca_rels_rel_id_fk
                                references dotlrn_admin_rels (rel_id)
                                constraint dotlrn_ca_rels_rel_id_pk
                                primary key
);

create or replace view dotlrn_ca_rels_full
as
    select acs_rels.rel_id,
           acs_rels.object_id_one as community_id,
           acs_rels.object_id_two as user_id,
           acs_rels.rel_type
    from dotlrn_ca_rels,
         acs_rels
    where dotlrn_ca_rels.rel_id = acs_rels.rel_id;

create table dotlrn_instructor_rels (
    rel_id                      constraint dotlrn_instructor_rels_rel_fk
                                references dotlrn_admin_rels(rel_id)
                                constraint dotlrn_instructor_rels_rel_pk
                                primary key
);

create view dotlrn_instructor_rels_full
as
    select acs_rels.rel_id as rel_id,
           acs_rels.object_id_two as community_id,
           acs_rels.object_id_two as user_id,
           acs_rels.rel_type
    from dotlrn_instructor_rels,
         acs_rels
    where dotlrn_instructor_rels.rel_id = acs_rels.rel_id;

--
-- Object Types and Attributes
--

declare
    foo        integer;
begin
    acs_rel_type.create_type (
        rel_type => 'dotlrn_member_rel',
        supertype => 'membership_rel',
        pretty_name => 'dotLRN Community Membership',
        pretty_plural => 'dotLRN Community Memberships',
        package_name => 'dotlrn_member_rel',
        table_name => 'dotlrn_member_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_community', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'member',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    acs_rel_type.create_type (
        rel_type => 'dotlrn_admin_rel',
        supertype => 'dotlrn_member_rel',
        pretty_name => 'dotLRN Admin Community Membership',
        pretty_plural => 'dotLRN Admin Community Memberships',
        package_name => 'dotlrn_admin_rel',
        table_name => 'dotlrn_admin_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_community', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'admin',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    acs_rel_type.create_type (
        rel_type => 'dotlrn_student_rel',
        supertype => 'dotlrn_member_rel',
        pretty_name => 'dotLRN Student Community Membership',
        pretty_plural => 'dotLRN Student Community Memberships',
        package_name => 'dotlrn_student_rel',
        table_name => 'dotlrn_student_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_class_instance', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'student',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    acs_rel_type.create_type (
        rel_type => 'dotlrn_ta_rel',
        supertype => 'dotlrn_admin_rel',
        pretty_name => 'dotLRN Teaching Assistant Community Membership',
        pretty_plural => 'dotLRN Teaching Assistant Community Memberships',
        package_name => 'dotlrn_ta_rel',
        table_name => 'dotlrn_ta_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_class_instance', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'teaching_assistant',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    acs_rel_type.create_type (
        rel_type => 'dotlrn_ca_rel',
        supertype => 'dotlrn_admin_rel',
        pretty_name => 'dotLRN Course Assitant Community Membership',
        pretty_plural => 'dotLRN Course Assitant Community Memberships',
        package_name => 'dotlrn_ca_rel',
        table_name => 'dotlrn_ca_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_class_instance', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'course_assistant',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    acs_rel_type.create_type (
        rel_type => 'dotlrn_instructor_rel',
        supertype => 'dotlrn_admin_rel',
        pretty_name => 'dotLRN Instructor Community Membership',
        pretty_plural => 'dotLRN Instructor Community Memberships',
        package_name => 'dotlrn_instructor_rel',
        table_name => 'dotlrn_instructor_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_class_instance', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'instructor',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    --
    -- and now for the attributes
    --
    foo:= acs_attribute.create_attribute (
        object_type => 'dotlrn_member_rel',
        attribute_name => 'portal_id',
        datatype => 'integer',
        pretty_name => 'Page ID',
        pretty_plural => 'Page IDs'
    );
end;
/
show errors
