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
-- The DotLRN applet service contract
--
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- started October 1st, 2001
-- we remember September 11th
-- 

-- This is the service contract for dotLRN applets. A dotlrn applet MUST
-- have AT LEAST the procs (with the proper arguments) defined below to work
-- as a dotlrn applet. See the short explanation of what the proc is about below

declare
    sc_dotlrn_contract integer;
    foo integer;
begin
    sc_dotlrn_contract := acs_sc_contract.new (
        contract_name => 'dotlrn_applet',
        contract_desc => 'dotLRN Applet contract'
    );
  
    -- A simple proc to return the pretty name of the applet
    foo := acs_sc_msg_type.new (
        msg_type_name => 'dotlrn_applet.GetPrettyName.InputType',
        msg_type_spec => ''
    );
  
    foo := acs_sc_msg_type.new (
        msg_type_name => 'dotlrn_applet.GetPrettyName.OutputType',
        msg_type_spec => 'pretty_name:string'
    );
  
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'GetPrettyName',
        'Get the pretty name of the applet',
        't', -- not cacheable
        0,   -- n_args
        'dotlrn_applet.GetPrettyName.InputType',
        'dotlrn_applet.GetPrettyName.OutputType'
    );
  
    -- Adds the applet to dotlrn (used for one-time initialization)
    -- Call in the the dotlrn-init sequence
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddApplet.InputType',
        msg_type_spec => ''
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddApplet.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'AddApplet',
        'Add the Applet to dotlrn - used for one-time initialization',
        'f', -- not cacheable
        0,   -- n_args
        'dotlrn_applet.AddApplet.InputType',
        'dotlrn_applet.AddApplet.OutputType'
    );
  
    -- Removes the applet from dotlrn (used for one-time destroy)
    -- ** Not yet implimented **
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveApplet.InputType',
        msg_type_spec => ''
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveApplet.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'RemoveApplet',
        'Remove the applet',
        'f', -- not cacheable
        0,   -- n_args
        'dotlrn_applet.RemoveApplet.InputType',
        'dotlrn_applet.RemoveApplet.OutputType'
    );

    -- Adds the applet to a community
    -- Called at community creation time. Adding applets after creation time
    -- is ** not implimented yet **
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddAppletToCommunity.InputType',
        msg_type_spec => 'community_id:integer'
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddAppletToCommunity.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'AddAppletToCommunity',
        'Add the Applet to a specific dotlrn community',
        'f', -- not cacheable
        1,   -- n_args
        'dotlrn_applet.AddAppletToCommunity.InputType',
        'dotlrn_applet.AddAppletToCommunity.OutputType'
    );
  
    -- Removes the applet from a community
    -- Called at community delete time. Deleting applets before that time
    -- ** not implimented yet **
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveAppletFromCommunity.InputType',
        msg_type_spec => 'community_id:integer'
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveAppletFromCommunity.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'RemoveAppletFromCommunity',
        'Remove the applet from a given community',
        'f', -- not cacheable
        1,   -- n_args
        'dotlrn_applet.RemoveAppletFromCommunity.InputType',
        'dotlrn_applet.RemoveAppletFromCommunity.OutputType'
    );
  
    -- AddUser: used for user-specific one time stuff
    -- Called when a user is added as a dotlrn user. An example:        
    -- dotlrn-calendar will create a personal calendar for the new user.
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddUser.InputType',
        msg_type_spec => 'user_id:integer'
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddUser.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'AddUser',
        'Add a user to dotlrn, used for user-specific one-time init',
        'f', -- not cacheable
        1,   -- n_args
        'dotlrn_applet.AddUser.InputType',
        'dotlrn_applet.AddUser.OutputType'
    );
  
    -- RemoveUser: used for user-specific one time stuff
    -- Just like AddUser above, but when we delete a dotlrn user
    -- Example: dotlrn-calendar would delete the user's personal calendar
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveUser.InputType',
        msg_type_spec => 'user_id:integer'
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveUser.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'RemoveUser',
        'Remove a user from dotlrn',
        'f', -- not cacheable
        1,   -- n_args
        'dotlrn_applet.RemoveUser.InputType',
        'dotlrn_applet.RemoveUser.OutputType'
    );
  
    -- Adds a user to the a specfic dotlrn community. An example of this 
    -- is to make the community's calendar items visable on user's personal 
    -- calendar
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddUserToCommunity.InputType',
        msg_type_spec => 'community_id:integer,user_id:integer'
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.AddUserToCommunity.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'AddUserToCommunity',
        'Add a user to a community',
        'f', -- not cacheable
        2,   -- n_args
        'dotlrn_applet.AddUserToCommunity.InputType',
        'dotlrn_applet.AddUserToCommunity.OutputType'
    );

    -- Removes a user from a specfic dotlrn community. Just like above, 
    -- but removal.
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveUserFromCommunity.InputType',
        msg_type_spec => 'community_id:integer,user_id:integer'
    );
  
    foo := acs_sc_msg_type.new(
        msg_type_name => 'dotlrn_applet.RemoveUserFromCommunity.OutputType',
        msg_type_spec => 'success_p:boolean,error_message:string'
    );
    
    foo := acs_sc_operation.new (
        'dotlrn_applet',
        'RemoveUserFromCommunity',
        'Remove a user from a community, applet does appropriate cleanup',
        'f', -- not cacheable
        2,   -- n_args
        'dotlrn_applet.RemoveUserFromCommunity.InputType',
        'dotlrn_applet.RemoveUserFromCommunity.OutputType'
    );
  
  
  
  
end;
/
show errors
