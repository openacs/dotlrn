
--
-- The DotLRN communities membership constructs
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
-- ported to PG by Yon and Ben
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @creation-date  November 6th, 2001
-- @version $Id$
--

create table dotlrn_member_rels (
    rel_id                      integer
                                constraint dotlrn_member_rels_rel_id_fk
                                references membership_rels (rel_id)
                                constraint dotlrn_member_rels_rel_id_pk
                                primary key,
    portal_id                   integer
                                constraint dotlrn_member_rels_portal_fk
                                references portals (portal_id)
);                                          

create view dotlrn_member_rels_full
as
    select acs_rels.rel_id as rel_id,
           acs_rels.object_id_one as community_id,
           acs_rels.object_id_two as user_id,
           acs_rels.rel_type,
           (select acs_rel_roles.pretty_name
            from acs_rel_roles
            where acs_rel_roles.role = (select acs_rel_types.role_two
                                        from acs_rel_types
                                        where acs_rel_types.rel_type = acs_rels.rel_type)) as role,
           dotlrn_member_rels.portal_id,
           membership_rels.member_state
    from dotlrn_member_rels,
         acs_rels,
         membership_rels
    where dotlrn_member_rels.rel_id = acs_rels.rel_id
    and acs_rels.rel_id = membership_rels.rel_id;

create view dotlrn_member_rels_approved
as
    select *
    from dotlrn_member_rels_full
    where member_state = 'approved';

create table dotlrn_admin_rels (
    rel_id                      integer
                                constraint dotlrn_admin_rels_rel_id_fk
                                references dotlrn_member_rels (rel_id)
                                constraint dotlrn_admin_rels_rel_id_pk
                                primary key
);

create view dotlrn_admin_rels_full
as
    select dotlrn_member_rels_full.rel_id,
           dotlrn_member_rels_full.community_id,
           dotlrn_member_rels_full.user_id,
           dotlrn_member_rels_full.rel_type,
           dotlrn_member_rels_full.role,
           dotlrn_member_rels_full.portal_id,
           dotlrn_member_rels_full.member_state
    from dotlrn_member_rels_full,
         dotlrn_admin_rels
    where dotlrn_member_rels_full.rel_id = dotlrn_admin_rels.rel_id;

--
-- For Classes
--

create table dotlrn_student_rels (
    rel_id                      integer
                                constraint dotlrn_student_rels_rel_id_fk
                                references dotlrn_member_rels (rel_id)
                                constraint dotlrn_student_rels_rel_id_pk
                                primary key
);

create view dotlrn_student_rels_full
as
    select dotlrn_member_rels_full.rel_id,
           dotlrn_member_rels_full.community_id,
           dotlrn_member_rels_full.user_id,
           dotlrn_member_rels_full.rel_type,
           dotlrn_member_rels_full.role,
           dotlrn_member_rels_full.portal_id,
           dotlrn_member_rels_full.member_state
    from dotlrn_member_rels_full,
         dotlrn_student_rels
    where dotlrn_member_rels_full.rel_id = dotlrn_student_rels.rel_id;

create table dotlrn_ta_rels (
    rel_id                      integer
                                constraint dotlrn_ta_rels_rel_id_fk
                                references dotlrn_admin_rels (rel_id)
                                constraint dotlrn_ta_rels_rel_id_pk
                                primary key
);

create view dotlrn_ta_rels_full
as
    select dotlrn_admin_rels_full.rel_id,
           dotlrn_admin_rels_full.community_id,
           dotlrn_admin_rels_full.user_id,
           dotlrn_admin_rels_full.rel_type,
           dotlrn_admin_rels_full.role,
           dotlrn_admin_rels_full.portal_id,
           dotlrn_admin_rels_full.member_state
    from dotlrn_admin_rels_full,
         dotlrn_ta_rels
    where dotlrn_admin_rels_full.rel_id = dotlrn_ta_rels.rel_id;

create table dotlrn_ca_rels (
    rel_id                      integer
                                constraint dotlrn_ca_rels_rel_id_fk
                                references dotlrn_admin_rels (rel_id)
                                constraint dotlrn_ca_rels_rel_id_pk
                                primary key
);

create view dotlrn_ca_rels_full
as
    select dotlrn_admin_rels_full.rel_id,
           dotlrn_admin_rels_full.community_id,
           dotlrn_admin_rels_full.user_id,
           dotlrn_admin_rels_full.rel_type,
           dotlrn_admin_rels_full.role,
           dotlrn_admin_rels_full.portal_id,
           dotlrn_admin_rels_full.member_state
    from dotlrn_admin_rels_full,
         dotlrn_ca_rels
    where dotlrn_admin_rels_full.rel_id = dotlrn_ca_rels.rel_id;

create table dotlrn_cadmin_rels (
    rel_id                      integer
                                constraint dotlrn_cadmin_rels_rel_id_fk
                                references dotlrn_admin_rels (rel_id)
                                constraint dotlrn_cadmin_rels_rel_id_pk
                                primary key
);

create view dotlrn_cadmin_rels_full
as
    select dotlrn_admin_rels_full.rel_id,
           dotlrn_admin_rels_full.community_id,
           dotlrn_admin_rels_full.user_id,
           dotlrn_admin_rels_full.rel_type,
           dotlrn_admin_rels_full.role,
           dotlrn_admin_rels_full.portal_id,
           dotlrn_admin_rels_full.member_state
    from dotlrn_admin_rels_full,
         dotlrn_cadmin_rels
    where dotlrn_admin_rels_full.rel_id = dotlrn_cadmin_rels.rel_id;

create table dotlrn_instructor_rels (
    rel_id                      integer
                                constraint dotlrn_instructor_rels_rel_fk
                                references dotlrn_admin_rels(rel_id)
                                constraint dotlrn_instructor_rels_rel_pk
                                primary key
);

create view dotlrn_instructor_rels_full
as
    select dotlrn_admin_rels_full.rel_id,
           dotlrn_admin_rels_full.community_id,
           dotlrn_admin_rels_full.user_id,
           dotlrn_admin_rels_full.rel_type,
           dotlrn_admin_rels_full.role,
           dotlrn_admin_rels_full.portal_id,
           dotlrn_admin_rels_full.member_state
    from dotlrn_admin_rels_full,
         dotlrn_instructor_rels
    where dotlrn_admin_rels_full.rel_id = dotlrn_instructor_rels.rel_id;

--
-- Object Types and Attributes
--

select acs_rel_type__create_type (
        'dotlrn_member_rel',
        'dotLRN Community Membership',
        'dotLRN Community Memberships',
        'membership_rel',
        'dotlrn_member_rels',        
        'rel_id',
        'dotlrn_member_rel',
        'dotlrn_community', null, 
        0, null,
        'user', 'member',
        0, null
    );

    select acs_rel_type__create_type (
        'dotlrn_admin_rel',
        'dotLRN Admin Community Membership',
        'dotLRN Admin Community Memberships',
        'dotlrn_member_rel',
        'dotlrn_admin_rels',        
        'rel_id',
        'dotlrn_admin_rel',
        'dotlrn_community', null, 
        0, null,
        'user', 'admin',
        0, null
    );

    select acs_rel_type__create_type (
        'dotlrn_student_rel',
        'dotLRN Student Community Membership',
        'dotLRN Student Community Memberships',
        'dotlrn_member_rel',
        'dotlrn_student_rels',        
        'rel_id',
        'dotlrn_student_rel',
        'dotlrn_class_instance', null, 
        0, null,
        'user', 'student',
        0, null
    );

    select acs_rel_type__create_type (
        'dotlrn_ta_rel',
        'dotLRN Teaching Assistant Community Membership',
        'dotLRN Teaching Assistant Community Memberships',
        'dotlrn_admin_rel',
        'dotlrn_ta_rels',        
        'rel_id',
        'dotlrn_ta_rel',
        'dotlrn_class_instance', null, 
        0, null,
        'user', 'teaching_assistant',
        0, null
    );

    select acs_rel_type__create_type (
        'dotlrn_ca_rel',
        'dotLRN Course Assitant Community Membership',
        'dotLRN Course Assitant Community Memberships',
        'dotlrn_admin_rel',
        'dotlrn_ca_rels',        
        'rel_id',
        'dotlrn_ca_rel',
        'dotlrn_class_instance', null, 
        0, null,
        'user', 'course_assistant',
        0, null
    );

    select acs_rel_type__create_type (
        'dotlrn_cadmin_rel',
        'dotlrn_admin_rel',
        'dotLRN Course Administrator Community Membership',
        'dotLRN Course Administrator Community Memberships',
        'dotlrn_cadmin_rel',
        'dotlrn_cadmin_rels',        
        'rel_id',
        'dotlrn_class_instance', null, 
        0, null,
        'user', 'course_admin',
        0, null
    );

    select acs_rel_type__create_type (
        'dotlrn_instructor_rel',
        'dotLRN Instructor Community Membership',
        'dotLRN Instructor Community Memberships',
        'dotlrn_admin_rel',
        'dotlrn_instructor_rels',        
        'rel_id',
        'dotlrn_instructor_rel',
        'dotlrn_class_instance', null, 
        0, null,
        'user', 'instructor',
        0, null
    );

    --
    -- and now for the attributes
    --
    select acs_attribute__create_attribute (
        'dotlrn_member_rel',
        'portal_id',
        'integer',
        'Page ID',
        'Page IDs',
        NULL,
        NULL,
        NULL,
        1,
        1,
        NULL,
        'type_specific',
        'f'
    );
end;
