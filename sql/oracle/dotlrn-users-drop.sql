--
-- Drop the User Profile package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

-- drop students
@@ dotlrn-students-drop.sql

-- drop professors
@@ dotlrn-professors-drop.sql

-- drop admins
@@ dotlrn-admins-drop.sql

@@ dotlrn-users-package-drop.sql
@@ dotlrn-users-sanitize.sql
@@ dotlrn-user-profile-provider-drop.sql

drop view dotlrn_full_users;
drop view dotlrn_users;

drop table dotlrn_user_types;
drop table dotlrn_full_user_profile_rels;
drop table dotlrn_user_profile_rels;
