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
-- The dotLRN extension to user data notifications
-- copyright 2002, OpenForce
-- distributed under GPL v2.0
--
--
-- @author dan chak (chak@mit.edu)
-- @version $Id$
--
-- 
--


begin

    perform acs_sc_binding__delete (
        'UserData',
        'dotlrn_user_extension'
    );

    perform acs_sc_impl__delete_alias (
        'UserData',
        'dotlrn_user_extension',
        'UserNew'
    );

    perform acs_sc_impl__delete_alias (
        'UserData',
        'dotlrn_user_extension',
        'UserApprove'
    );

    perform acs_sc_impl__delete_alias (
        'UserData',
        'dotlrn_user_extension',
        'UserDeapprove'
    );

    perform acs_sc_impl__delete_alias (
        'UserData',
        'dotlrn_user_extension',
        'UserModify'
    );

    perform acs_sc_impl__delete_alias (
        'UserData',
        'dotlrn_user_extension',
        'UserDelete'
    );

    -- create the implementation
    perform acs_sc_impl__delete(
        'UserData',
        'dotlrn_user_extension'
    );

end;
