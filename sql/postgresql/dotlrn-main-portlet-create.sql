--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
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
-- packages/dotlrn/sql/oracle/dotlrn-main-portlet-create.sql
--

-- Creates a dotLRN datasource for including on a user's main portal page.

-- Copyright (C) 2001 OpenForce, Inc.
-- @author Ben Adida (ben@openforce.net)
-- @author dan chak (chak@openforce.net)
-- @creation-date 2001-11-05

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

create function inline_0 ()
returns integer as '
declare
begin
    ds_id portal_datasources.datasource_id%TYPE;
begin
    ds_id := portal_datasource__new(
        ''dotlrn_main_portlet'',
        ''Displays the list of communities a user belongs to''
    );

    --  the standard 4 params

    -- shadeable_p
    perform portal_datasource.set_def_param(
        ds_id, ''t'', ''t'', ''shadeable_p'', ''f''
    );

    -- hideable_p
    perform portal_datasource__set_def_param(
        ds_id, ''t'', ''t'', ''hideable_p'', ''f''
    );

    -- user_editable_p
    perform portal_datasource__set_def_param(
        ds_id, ''t'', ''t'', ''user_editable_p'', ''f''
    );

    -- shaded_p
    perform portal_datasource__set_def_param(
        ds_id, ''t'', ''t'', ''shaded_p'', ''f''
    );

    -- link_hideable_p
    perform portal_datasource__set_def_param(
        ds_id, ''t'', ''t'', ''link_hideable_p'', ''t''
    );

    -- create the implementation
    perform acs_sc_impl__new(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''dotlrn_main_portlet''
    );

        -- add all the hooks
    perform acs_sc_impl_alias__new (
           ''portal_datasource'',
           ''dotlrn_main_portlet'',
           ''GetMyName'',
           ''dotlrn_main_portlet::get_my_name'',
           ''TCL''
    );

    perform acs_sc_impl_alias__new (
           ''portal_datasource'',
               ''dotlrn_main_portlet'',
               ''GetPrettyName'',
               ''dotlrn_main_portlet::get_pretty_name'',
               ''TCL''
        );

        perform acs_sc_impl_alias__new (
               ''portal_datasource'',
               ''dotlrn_main_portlet'',
               ''Link'',
               ''dotlrn_main_portlet::link'',
               ''TCL''
        );

        perform acs_sc_impl_alias__new (
               ''portal_datasource'',
               ''dotlrn_main_portlet'',
               ''AddSelfToPage'',
               ''dotlrn_main_portlet::add_self_to_page'',
               ''TCL''
        );

        perform acs_sc_impl_alias__new (
               ''portal_datasource'',
               ''dotlrn_main_portlet'',
               ''RemoveSelfFromPage'',
               ''dotlrn_main_portlet::remove_self_from_page'',
               ''TCL''
        );

        perform acs_sc_impl_alias__new (
               ''portal_datasource'',
               ''dotlrn_main_portlet'',
               ''Show'',
               ''dotlrn_main_portlet::show'',
               ''TCL''
        );

        perform acs_sc_impl_alias__new (
               ''portal_datasource'',
               ''dotlrn_main_portlet'',
               ''Edit'',
               ''dotlrn_main_portlet::edit'',
               ''TCL''
        );

        -- Add the binding
        perform acs_sc_binding__new (
               ''portal_datasource'',
               ''dotlrn_main_portlet''
        );

	return 0;

end;
' language 'plpgsql';

select inline_0();
drop function inline_0();
