--
-- Create the dotLRN Admins package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create table dotlrn_admin_profile_rels (
    rel_id                      integer
                                constraint dotlrn_adm_prfl_rels_rel_id_fk
                                references dotlrn_user_profile_rels (rel_id)
                                constraint dotlrn_admin_prfl_rels_pk
                                primary key
);

create table dotlrn_full_admin_profile_rels (
    rel_id                      integer
                                constraint dotlrn_fl_adm_prfl_rels_rel_fk
                                references dotlrn_full_user_profile_rels (rel_id)
                                constraint dotlrn_full_admin_prfl_rels_pk
                                primary key
);

@@ dotlrn-admin-profile-provider-create.sql
@@ dotlrn-admins-init.sql
@@ dotlrn-admins-package-create.sql
