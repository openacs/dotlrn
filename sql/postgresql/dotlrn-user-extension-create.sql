
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
