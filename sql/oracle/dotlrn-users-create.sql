--
-- Create the dotLRN Users package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_user_profile_rels (
    rel_id                      constraint dotlrn_usr_prfl_rels_rel_id_fk
                                references user_profile_rels (rel_id)
                                constraint dotlrn_user_profile_rels_pk
                                primary key,
    id                          varchar2(100)
);

create table dotlrn_full_user_profile_rels (
    rel_id                      constraint dotlrn_fup_rels_rel_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_full_user_prfl_rels_pk
                                primary key,
    portal_id                   constraint dotlrn_fup_rels_portal_fk
                                references portals (portal_id)
                                constraint dotlrn_fup_rels_portal_nn
                                not null,
    theme_id                    constraint dotlrn_fup_rels_theme_fk
                                references portal_element_themes (theme_id)
);

create table dotlrn_user_types (
    type                        varchar2(100)
                                constraint dotlrn_user_types_pk
                                primary key,
    pretty_name                 varchar2(200),
    group_id                    constraint dotlrn_user_types_group_id_fk
                                references profiled_groups (group_id)
                                constraint dotlrn_user_types_group_id_nn
                                not null
);

create or replace view dotlrn_users
as
    select acs_rels.rel_id,
           dotlrn_user_profile_rels.id,
           registered_users.user_id,
           registered_users.first_names,
           registered_users.last_name,
           registered_users.email,
           dotlrn_user_types.type,
           dotlrn_user_types.pretty_name as pretty_type,
           dotlrn_user_types.group_id
    from dotlrn_user_profile_rels,
         acs_rels,
         registered_users,
         dotlrn_user_types
    where acs_rels.object_id_two = registered_users.user_id
    and acs_rels.object_id_one = dotlrn_user_types.group_id
    and acs_rels.rel_id = dotlrn_user_profile_rels.rel_id;

create or replace view dotlrn_full_users
as
    select dotlrn_users.*,
           dotlrn_full_user_profile_rels.portal_id,
           dotlrn_full_user_profile_rels.theme_id
    from dotlrn_users,
         dotlrn_full_user_profile_rels
    where dotlrn_users.rel_id = dotlrn_full_user_profile_rels.rel_id;

@@ dotlrn-user-profile-provider-create.sql
@@ dotlrn-users-init.sql
@@ dotlrn-users-package-create.sql

-- create administrators
@@ dotlrn-admins-create.sql

-- create professors
@@ dotlrn-professors-create.sql

-- create students
@@ dotlrn-students-create.sql

-- create external users
@@ dotlrn-externals-create.sql
