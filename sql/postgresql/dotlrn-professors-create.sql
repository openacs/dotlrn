--
-- Create the dotLRN Professors package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_professor_profile_rels (
    rel_id                      integer
                                constraint dotlrn_prof_rels_rel_id_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_prof_profile_rels_pk
                                primary key
);

create table dotlrn_full_prof_profile_rels (
    rel_id                      integer
                                constraint dotlrn_fp_prfl_rels_rel_fk
                                references dotlrn_full_user_profile_rels (rel_id)
                                constraint dotlrn_full_prof_prfl_rels_pk
                                primary key
);

\i dotlrn-professor-profile-provider-create.sql
\i dotlrn-professors-init.sql
\i dotlrn-professors-package-create.sql
