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
-- packages/dotlrn/sql/oracle/dotlrn-main-portlet-create.sql
--

-- Creates a dotLRN datasource for including on a user's main portal page.

-- Copyright (C) 2001 MIT
-- @author Ben Adida (ben@openforce.net)
-- @creation-date 2001-11-05

-- $Id$

-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare
    ds_id portal_datasources.datasource_id%TYPE;
    foo integer;
begin

    ds_id := portal_datasource.new(
        name => 'dotlrn_main_portlet',
        description => 'Displays the list of communities a user belongs to'
    );

    -- shadeable_p 
    portal_datasource.set_def_param (
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'shadeable_p',
        value => 'f'
    );	

    -- hideable_p 
    portal_datasource.set_def_param (
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'hideable_p',
        value => 'f'
    );	

    -- user_editable_p 
    portal_datasource.set_def_param (
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'user_editable_p',
        value => 'f'
    );	

    -- shaded_p 
    portal_datasource.set_def_param (
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'shaded_p',
        value => 'f'
    );	

    -- link_hideable_p 
    portal_datasource.set_def_param (
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'link_hideable_p',
        value => 't'
    );

    -- create the implementation
    foo := acs_sc_impl.new (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_pretty_name => 'Dotlrn main portlet',
        impl_owner_name => 'dotlrn_main_portlet'
    );

    -- add all the hooks
    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'GetMyName',
        impl_alias => 'dotlrn_main_portlet::get_my_name',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'GetPrettyName',
        impl_alias => 'dotlrn_main_portlet::get_pretty_name',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'Link',
        impl_alias => 'dotlrn_main_portlet::link',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'AddSelfToPage',
        impl_alias => 'dotlrn_main_portlet::add_self_to_page',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'RemoveSelfFromPage',
        impl_alias => 'dotlrn_main_portlet::remove_self_from_page',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'Show',
        impl_alias => 'dotlrn_main_portlet::show',
        impl_pl => 'TCL'
    );

    foo := acs_sc_impl.new_alias (
        impl_contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet',
        impl_operation_name => 'Edit',
        impl_alias => 'dotlrn_main_portlet::edit',
        impl_pl => 'TCL'
    );

    -- Add the binding
    acs_sc_binding.new (
        contract_name => 'portal_datasource',
        impl_name => 'dotlrn_main_portlet'
    );

end;
/
show errors

