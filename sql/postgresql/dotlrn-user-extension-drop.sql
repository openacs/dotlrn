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

    select acs_sc_binding__delete (
        'UserData',
        'dotlrn_user_extension'
    );

    select acs_sc_impl_alias__delete (
        'UserData',
        'dotlrn_user_extension',
        'UserNew'
    );

    select acs_sc_impl_alias__delete (
        'UserData',
        'dotlrn_user_extension',
        'UserApprove'
    );

    select acs_sc_impl_alias__delete (
        'UserData',
        'dotlrn_user_extension',
        'UserDeapprove'
    );

    select acs_sc_impl_alias__delete (
        'UserData',
        'dotlrn_user_extension',
        'UserModify'
    );

    select acs_sc_impl_alias__delete (
        'UserData',
        'dotlrn_user_extension',
        'UserDelete'
    );

    -- create the implementation
    select acs_sc_impl__delete(
        'UserData',
        'dotlrn_user_extension'
    );

end;

