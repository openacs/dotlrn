
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
	sc_dotlrn_contract	integer;
	foo			integer;
begin
	sc_dotlrn_contract := acs_sc_contract.new(
		  contract_name => 'dotLRN_Applet',
		  contract_desc => 'dotLRN Applet implement a specific interface'
	);

	-- Add the applet to a community
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotLRN_Applet.AddApplet.InputType',
		  msg_type_spec => 'community_id:integer'
	);

	foo := acs_sc_msg_type.new(
	          msg_type_name => 'dotLRN_Applet.AddApplet.OutputType',
		  msg_type_spec => 'success_p:boolean,error_message:string'
	);
	
	foo := acs_sc_operation.new (
	          'dotLRN_Applet',
		  'AddApplet',
		  'Add the Applet to a community',
		  'f', -- not cacheable
		  1,   -- n_args
		  'dotLRN_Applet.AddApplet.InputType',
		  'dotLRN_Applet.AddApplet.OutputType'
	);

	-- add a user to the community
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotLRN_Applet.AddUser.InputType',
		  msg_type_spec => 'community_id:integer,user_id:integer'
	);

	foo := acs_sc_msg_type.new(
	          msg_type_name => 'dotLRN_Applet.AddUser.OutputType',
		  msg_type_spec => 'success_p:boolean,error_message:string'
	);
	
	foo := acs_sc_operation.new (
	          'dotLRN_Applet',
		  'AddUser',
		  'Add a user to a community, and set up appropriate things for that applet',
		  'f', -- not cacheable
		  2,   -- n_args
		  'dotLRN_Applet.AddUser.InputType',
		  'dotLRN_Applet.AddUser.OutputType'
	);


	-- remove a user from the community
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotLRN_Applet.RemoveUser.InputType',
		  msg_type_spec => 'community_id:integer,user_id:integer'
	);

	foo := acs_sc_msg_type.new(
	          msg_type_name => 'dotLRN_Applet.RemoveUser.OutputType',
		  msg_type_spec => 'success_p:boolean,error_message:string'
	);
	
	foo := acs_sc_operation.new (
	          'dotLRN_Applet',
		  'RemoveUser',
		  'Remove a user from a community, and set up appropriate things for that applet',
		  'f', -- not cacheable
		  2,   -- n_args
		  'dotLRN_Applet.RemoveUser.InputType',
		  'dotLRN_Applet.RemoveUser.OutputType'
	);

	-- remove the applet from a community
	foo := acs_sc_msg_type.new(
		  msg_type_name => 'dotLRN_Applet.RemoveApplet.InputType',
		  msg_type_spec => 'community_id:integer'
	);

	foo := acs_sc_msg_type.new(
	          msg_type_name => 'dotLRN_Applet.RemoveApplet.OutputType',
		  msg_type_spec => 'success_p:boolean,error_message:string'
	);
	
	foo := acs_sc_operation.new (
	          'dotLRN_Applet',
		  'RemoveApplet',
		  'Remove a user from a community, and set up appropriate things for that applet',
		  'f', -- not cacheable
		  1,   -- n_args
		  'dotLRN_Applet.RemoveApplet.InputType',
		  'dotLRN_Applet.RemoveApplet.OutputType'
	);


end;
/
show errors
