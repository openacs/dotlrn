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


-- Drops dotLRN main portlet datasources for portal portlets

-- Copyright (C) 2001 Openforce, Inc. 
-- @author Ben Adida (ben@openforce.net)
-- @creation-date 2001-11-04

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

create function inline_0 ()
returns integer as '
declare  
  ds_id portal_datasources.datasource_id%TYPE;
begin

    perform acs_sc_binding__delete(
        ''portal_datasource'',
        ''dotlrn_main_portlet''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''GetMyName''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''GetPrettyName''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''Link''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''AddSelfToPage''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''RemoveSelfFromPage''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''Show''
    );

    perform acs_sc_impl__delete_alias(
        ''portal_datasource'',
        ''dotlrn_main_portlet'',
        ''Edit''
    );

    perform acs_sc_impl__delete(
        ''portal_datasource','
        ''dotlrn_main_portlet''
    );

  begin 
    select datasource_id into ds_id
      from portal_datasources
     where name = ''dotlrn-main-portlet'';
   exception when no_data_found then
     ds_id := null;
  end;

  if ds_id is not null then
    portal_datasource__delete(ds_id);
  end if;

end;
' language 'plpgsql';

perform inline_0();
delete function inline_0;
