--
-- Create the dotLRN Students package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_student_profile_rels (
    rel_id                      constraint dotlrn_std_rels_rel_id_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_student_profile_rels_pk
                                primary key
);

create table dotlrn_full_stud_profile_rels (
    rel_id                      constraint dotlrn_fs_prfl_rels_rel_fk
                                references dotlrn_full_user_profile_rels (rel_id)
                                constraint dotlrn_fs_prfl_rels_pk
                                primary key
);

@@ dotlrn-student-profile-provider-create.sql
@@ dotlrn-students-init.sql
@@ dotlrn-students-package-create.sql
