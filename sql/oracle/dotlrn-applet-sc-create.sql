
--
-- The DotLRN communities construct
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- started October 1st, 2001
-- we remember September 11th
--

-- This is the service contract for dotLRN components

declare
	sc_dotlrn_contract integer;
	foo integer;
begin
	sc_dotlrn_contract := acs_sc_contract.new (
		  contract_name => 'dotlrn_applet',
		  contract_desc => 'dotLRN Applet implement a specific interface'
	);

	-- Get a pretty name
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
		  'Get the pretyt name',
		  't', -- not cacheable
		  0,   -- n_args
		  'dotlrn_applet.GetPrettyName.InputType',
		  'dotlrn_applet.GetPrettyName.OutputType'
	);

	-- Add the applet to dotlrn (used for one-time initialization)
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
		  1,   -- n_args
		  'dotlrn_applet.AddApplet.InputType',
		  'dotlrn_applet.AddApplet.OutputType'
	);

	-- Add the applet to a community
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

	-- add a user to dotlrn (used for user-specific one time stuff)
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotlrn_applet.AddUser.InputType',
		  msg_type_spec => 'community_id:integer,user_id:integer'
	);

	foo := acs_sc_msg_type.new(
	          msg_type_name => 'dotlrn_applet.AddUser.OutputType',
		  msg_type_spec => 'success_p:boolean,error_message:string'
	);
	
	foo := acs_sc_operation.new (
	          'dotlrn_applet',
		  'AddUser',
		  'Add a user to dotlrn, used for user-specific one-time stuff',
		  'f', -- not cacheable
		  2,   -- n_args
		  'dotlrn_applet.AddUser.InputType',
		  'dotlrn_applet.AddUser.OutputType'
	);


	-- add a user to the a specfic dotlrn community
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
		  'Add a user to a community, and set up appropriate things for that applet',
		  'f', -- not cacheable
		  2,   -- n_args
		  'dotlrn_applet.AddUserToCommunity.InputType',
		  'dotlrn_applet.AddUserToCommunity.OutputType'
	);


	-- remove a user from the community
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotlrn_applet.RemoveUser.InputType',
		  msg_type_spec => 'community_id:integer,user_id:integer'
	);

	foo := acs_sc_msg_type.new(
	          msg_type_name => 'dotlrn_applet.RemoveUser.OutputType',
		  msg_type_spec => 'success_p:boolean,error_message:string'
	);
	
	foo := acs_sc_operation.new (
	          'dotlrn_applet',
		  'RemoveUser',
		  'Remove a user from a community, and set up appropriate things for that applet',
		  'f', -- not cacheable
		  2,   -- n_args
		  'dotlrn_applet.RemoveUser.InputType',
		  'dotlrn_applet.RemoveUser.OutputType'
	);

	-- remove the applet from a community
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotlrn_applet.RemoveApplet.InputType',
		  msg_type_spec => 'community_id:integer,package_id:integer'
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
		  2,   -- n_args
		  'dotlrn_applet.RemoveApplet.InputType',
		  'dotlrn_applet.RemoveApplet.OutputType'
	);


end;
/
show errors
