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
-- drop the dotLRN applet service contract
--
-- started October 1st, 2001
-- we remember September 11th
--
-- @author dan chak (chak@openforce.net)
-- porting to PG on 2002-07-01

begin

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'GetPrettyName'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.GetPrettyName.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.GetPrettyName.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'AddApplet'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddApplet.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddApplet.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'RemoveApplet'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveApplet.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveApplet.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'AddAppletToCommunity'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddAppletToCommunity.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddAppletToCommunity.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'RemoveAppletFromCommunity'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveAppletFromCommunity.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveAppletFromCommunity.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'AddUser'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddUser.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddUser.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'RemoveUser'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveUser.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveUser.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'AddUserToCommunity'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddUserToCommunity.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddUserToCommunity.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'RemoveUserFromCommunity'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveUserFromCommunity.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemoveUserFromCommunity.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'AddPortlet'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddPortlet.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.AddPortlet.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'RemovePortlet'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemovePortlet.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.RemovePortlet.OutputType'
    );

    select acs_sc_operation__delete(
        'dotlrn_applet',
        'Clone'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.Clone.InputType'
    );

    select acs_sc_msg_type__delete(
        'dotlrn_applet.Clone.OutputType'
    );

    select acs_sc_contract__delete(
        'dotlrn_applet'
    );

end;

