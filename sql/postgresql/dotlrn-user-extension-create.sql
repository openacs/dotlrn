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
-- ported to PG by Yon and Ben
-- ben@openforce.net
--
-- 01/22/2002
--


begin
        -- create the implementation
        select acs_sc_impl__new (
                'UserData',
                'dotlrn_user_extension',
                'dotlrn_user_extension'
        );

        -- add all the hooks

        -- UserNew
        select acs_sc_impl_alias__new (
               'UserData',
               'dotlrn_user_extension',
               'UserNew',
               'dotlrn_user_extension::user_new',
               'TCL'
        );

        -- UserNew
        select acs_sc_impl_alias__new (
               'UserData',
               'dotlrn_user_extension',
               'UserApprove',
               'dotlrn_user_extension::user_approve',
               'TCL'
        );

        -- UserNew
        select acs_sc_impl_alias__new (
               'UserData',
               'dotlrn_user_extension',
               'UserDeapprove',
               'dotlrn_user_extension::user_deapprove',
               'TCL'
        );

        -- UserNew
        select acs_sc_impl_alias__new (
               'UserData',
               'dotlrn_user_extension',
               'UserModify',
               'dotlrn_user_extension::user_modify',
               'TCL'
        );

        -- UserNew
        select acs_sc_impl_alias__new (
               'UserData',
               'dotlrn_user_extension',
               'UserDelete',
               'dotlrn_user_extension::user_delete',
               'TCL'
        );

        -- Add the binding
        select acs_sc_binding__new (
            'UserData',
            'dotlrn_user_extension'
        );
end;
