--
-- Create the dotLRN Externals package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_external_profile_rels (
    rel_id                      constraint dotlrn_ext_rels_rel_id_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_ext_profile_rels_pk
                                primary key
);

create table dotlrn_full_ext_profile_rels (
    rel_id                      constraint dotlrn_fe_prfl_rels_rel_fk
                                references dotlrn_full_user_profile_rels (rel_id)
                                constraint dotlrn_fe_prfl_rels_pk
                                primary key
);

@@ dotlrn-external-profile-provider-create.sql
@@ dotlrn-externals-init.sql
@@ dotlrn-externals-package-create.sql
