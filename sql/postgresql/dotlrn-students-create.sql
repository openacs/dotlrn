--
-- Create the dotLRN Students package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_student_profile_rels (
    rel_id                      integer
                                constraint dotlrn_std_rels_rel_id_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_student_profile_rels_pk
                                primary key
);

create table dotlrn_full_stud_profile_rels (
    rel_id                      integer
                                constraint dotlrn_fs_prfl_rels_rel_fk
                                references dotlrn_full_user_profile_rels (rel_id)
                                constraint dotlrn_fs_prfl_rels_pk
                                primary key
);

\i dotlrn-student-profile-provider-create.sql
\i dotlrn-students-init.sql
\i dotlrn-students-package-create.sql
