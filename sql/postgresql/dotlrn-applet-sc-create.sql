--
-- The DotLRN applet service contract
--
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net, arjun@openforce.net
-- ported to PG by Yon and Ben
--
-- started October 1st, 2001
-- we remember September 11th
-- 

-- This is the service contract for dotLRN applets. A dotlrn applet MUST
-- have AT LEAST the procs (with the proper arguments) defined below to work
-- as a dotlrn applet.

begin
        select acs_sc_contract__new (
                  'dotlrn_applet',
                  'dotLRN Applet contract'
        );

        -- Get a pretty name
        select acs_sc_msg_type__new (
                  'dotlrn_applet.GetPrettyName.InputType',
                  ''
        );

        select acs_sc_msg_type__new (
                  'dotlrn_applet.GetPrettyName.OutputType',
                  'pretty_name:string'
        );

        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'GetPrettyName',
                  'Get the pretty name of the applet',
                  't', -- not cacheable
                  0,   -- n_args
                  'dotlrn_applet.GetPrettyName.InputType',
                  'dotlrn_applet.GetPrettyName.OutputType'
        );

        -- Add the applet to dotlrn (used for one-time initialization)
        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddApplet.InputType',
                  ''
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddApplet.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'AddApplet',
                  'Add the Applet to dotlrn - used for one-time initialization',
                  'f', -- not cacheable
                  0,   -- n_args
                  'dotlrn_applet.AddApplet.InputType',
                  'dotlrn_applet.AddApplet.OutputType'
        );

        -- Add the applet to a community
        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddAppletToCommunity.InputType',
                  'community_id:integer'
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddAppletToCommunity.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'AddAppletToCommunity',
                  'Add the Applet to a specific dotlrn community',
                  'f', -- not cacheable
                  1,   -- n_args
                  'dotlrn_applet.AddAppletToCommunity.InputType',
                  'dotlrn_applet.AddAppletToCommunity.OutputType'
        );

        -- add a user to dotlrn (used for user-specific one time stuff)
        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddUser.InputType',
                  'user_id:integer'
        );

        select acs_sc_msg_type.new(
                  'dotlrn_applet.AddUser.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'AddUser',
                  'Add a user to dotlrn, used for user-specific one-time init',
                  'f', -- not cacheable
                  1,   -- n_args
                  'dotlrn_applet.AddUser.InputType',
                  'dotlrn_applet.AddUser.OutputType'
        );


        -- add a user to the a specfic dotlrn community
        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddUserToCommunity.InputType',
                  'community_id:integer,user_id:integer'
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.AddUserToCommunity.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'AddUserToCommunity',
                  'Add a user to a community',
                  'f', -- not cacheable
                  2,   -- n_args
                  'dotlrn_applet.AddUserToCommunity.InputType',
                  'dotlrn_applet.AddUserToCommunity.OutputType'
        );

        -- remove a user from dotlrn
        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveUser.InputType',
                  'user_id:integer'
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveUser.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'RemoveUser',
                  'Remove a user from dotlrn',
                  'f', -- not cacheable
                  1,   -- n_args
                  'dotlrn_applet.RemoveUser.InputType',
                  'dotlrn_applet.RemoveUser.OutputType'
        );

        -- remove a user from the community
        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveUserFromCommunity.InputType',
                  'community_id:integer,user_id:integer'
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveUserFromCommunity.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'RemoveUserFromCommunity',
                  'Remove a user from a community, applet does appropriate cleanup',
                  'f', -- not cacheable
                  2,   -- n_args
                  'dotlrn_applet.RemoveUserFromCommunity.InputType',
                  'dotlrn_applet.RemoveUserFromCommunity.OutputType'
        );

        -- remove the applet from dotlrn
        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveApplet.InputType',
                  ''
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveApplet.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'RemoveApplet',
                  'Remove the applet',
                  'f', -- not cacheable
                  0,   -- n_args
                  'dotlrn_applet.RemoveApplet.InputType',
                  'dotlrn_applet.RemoveApplet.OutputType'
        );

        -- remove the applet from a community
        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveAppletFromCommunity.InputType',
                  'community_id:integer'
        );

        select acs_sc_msg_type__new(
                  'dotlrn_applet.RemoveAppletFromCommunity.OutputType',
                  'success_p:boolean,error_message:string'
        );
        
        select acs_sc_operation__new (
                  'dotlrn_applet',
                  'RemoveAppletFromCommunity',
                  'Remove the applet from a given community',
                  'f', -- not cacheable
                  2,   -- n_args
                  'dotlrn_applet.RemoveAppletFromCommunity.InputType',
                  'dotlrn_applet.RemoveAppletFromCommunity.OutputType'
        );

end;
