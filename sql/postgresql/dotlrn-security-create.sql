
--
-- dotLRN Project
--
-- copyright 2001, OpenForce
-- released under the GPL, v2.0
--
-- ben@openforce
-- ported to PG by Yon and Ben
--
-- 11/28/2001
--
-- Security Setup for dotLRN
-- privileges, privilege inheritance
--

BEGIN
        -- the ability to browse dotLRN in general
        PERFORM acs_privilege__create_privilege('dotlrn_browse');

        -- the ability to even view that a community exists
        PERFORM acs_privilege__create_privilege('dotlrn_view_community');

        -- the ability to participate in a community
        PERFORM acs_privilege__create_privilege('dotlrn_edit_community');

        -- the ability to admin a community
        PERFORM acs_privilege__create_privilege('dotlrn_admin_community');

        -- the ability to create a community
        PERFORM acs_privilege__create_privilege('dotlrn_create_community');

        -- the ability to even view a community type
        PERFORM acs_privilege__create_privilege('dotlrn_view_community_type');

        -- the ability to admin a community type
        PERFORM acs_privilege__create_privilege('dotlrn_admin_community_type');
        
        -- the ability to create a community type
        PERFORM acs_privilege__create_privilege('dotlrn_create_community_type');

        -- Consistent permissions
        PERFORM acs_privilege__add_child('dotlrn_edit_community', 'dotlrn_view_community');
        PERFORM acs_privilege__add_child('dotlrn_admin_community', 'dotlrn_edit_community');

        -- inheritance
        PERFORM acs_privilege__add_child('create', 'dotlrn_create_community_type');
        PERFORM acs_privilege__add_child('create', 'dotlrn_create_community');
        PERFORM acs_privilege__add_child('write', 'dotlrn_edit_community');
        PERFORM acs_privilege__add_child('read', 'dotlrn_view_community');
        PERFORM acs_privilege__add_child('read', 'dotlrn_view_community_type');
        PERFORM acs_privilege__add_child('admin', 'dotlrn_admin_community');
        PERFORM acs_privilege__add_child('admin', 'dotlrn_admin_community_type');

        -- for now, we only want admins to be able to browse by default
        PERFORM acs_privilege__add_child('admin', 'dotlrn_browse');

        -- no default permissions

end;
