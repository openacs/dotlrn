
--
-- The dotLRN extension to user data notifications
-- copyright 2002, OpenForce
-- distributed under GPL v2.0
--
--
-- ben@openforce.net
--
-- 01/22/2002
--


declare
	foo integer;
begin
	-- create the implementation
	foo := acs_sc_impl.new (
		'UserData',
		'dotlrn_user_extension',
		'dotlrn_user_extension'
	);

	-- add all the hooks

	-- UserNew
	foo := acs_sc_impl.new_alias (
	       'UserData',
	       'dotlrn_user_extension',
	       'UserNew',
	       'dotlrn_user_extension::user_new',
	       'TCL'
	);

	-- UserNew
	foo := acs_sc_impl.new_alias (
	       'UserData',
	       'dotlrn_user_extension',
	       'UserApprove',
	       'dotlrn_user_extension::user_approve',
	       'TCL'
	);

	-- UserNew
	foo := acs_sc_impl.new_alias (
	       'UserData',
	       'dotlrn_user_extension',
	       'UserDeapprove',
	       'dotlrn_user_extension::user_deapprove',
	       'TCL'
	);

	-- UserNew
	foo := acs_sc_impl.new_alias (
	       'UserData',
	       'dotlrn_user_extension',
	       'UserModify',
	       'dotlrn_user_extension::user_modify',
	       'TCL'
	);

	-- UserNew
	foo := acs_sc_impl.new_alias (
	       'UserData',
	       'dotlrn_user_extension',
	       'UserDelete',
	       'dotlrn_user_extension::user_delete',
	       'TCL'
	);

	-- Add the binding
	acs_sc_binding.new (
	    contract_name => 'UserData',
	    impl_name => 'dotlrn_user_extension'
	);
end;
/
show errors
