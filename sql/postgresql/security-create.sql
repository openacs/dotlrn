--
--  Copyright (C) 2001, 2002 MIT
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--


--
-- dotLRN Project
--
-- ben@openforce
-- ported to PG by Yon and Ben
-- @author dan chak (chak@openforce.net)
-- @version $Id$
--
-- creation date 11/28/2001
--
-- Security Setup for dotLRN
-- privileges, privilege inheritance
--
begin;
        -- the ability to browse dotLRN in general
        select acs_privilege__create_privilege('dotlrn_browse');

        -- the ability to even view that a community exists
        select acs_privilege__create_privilege('dotlrn_view_community');

        -- the ability to participate in a community
        select acs_privilege__create_privilege('dotlrn_edit_community');

        -- the ability to admin a community
        select acs_privilege__create_privilege('dotlrn_admin_community');

        -- the ability to create a community
        select acs_privilege__create_privilege('dotlrn_create_community');

        -- the ability to even view a community type
        select acs_privilege__create_privilege('dotlrn_view_community_type');

        -- the ability to admin a community type
        select acs_privilege__create_privilege('dotlrn_admin_community_type');
        
        -- the ability to create a community type
        select acs_privilege__create_privilege('dotlrn_create_community_type');

        -- temporarily drop this trigger to avoid a data-change violation 
        -- on acs_privilege_hierarchy_index while updating the child privileges.

        drop trigger acs_priv_hier_ins_del_tr on acs_privilege_hierarchy;

        -- Consistent permissions
        select acs_privilege__add_child('dotlrn_edit_community', 'dotlrn_view_community');
        select acs_privilege__add_child('dotlrn_admin_community', 'dotlrn_edit_community');

        -- inheritance
        select acs_privilege__add_child('create', 'dotlrn_create_community_type');
        select acs_privilege__add_child('create', 'dotlrn_create_community');
        select acs_privilege__add_child('write', 'dotlrn_edit_community');
        select acs_privilege__add_child('read', 'dotlrn_view_community');
        select acs_privilege__add_child('read', 'dotlrn_view_community_type');
        select acs_privilege__add_child('admin', 'dotlrn_admin_community');
        select acs_privilege__add_child('admin', 'dotlrn_admin_community_type');

        -- re-enable the trigger before the last insert to force the 
        -- acs_privilege_hierarchy_index table to be updated.

        create trigger acs_priv_hier_ins_del_tr after insert or delete
        on acs_privilege_hierarchy for each row
        execute procedure acs_priv_hier_ins_del_tr ();

        -- for now, we only want admins to be able to browse by default
        select acs_privilege__add_child('admin', 'dotlrn_browse');

        -- no default permissions

end;
