--
-- packages/dotlrn/sql/oracle/dotlrn-main-portlet-create.sql
--

-- Creates a dotLRN datasource for including on a user's main portal page.

-- Copyright (C) 2001 OpenForce, Inc.
-- @author Ben Adida (ben@openforce.net)
-- @creation-date 2001-11-05

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare
  ds_id portal_datasources.datasource_id%TYPE;
begin
  ds_id := portal_datasource.new(
    name             => 'dotlrn-main-portlet',
    description      => 'Displays the list of communities a user belongs to',
    content	     => 'dotlrn_main_portlet::show',
    configurable_p   => 't'
  );

end;
/
show errors

