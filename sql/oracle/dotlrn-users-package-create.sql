
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- October 30th, 2001
-- we remember September 11th, 2001
--

--
-- Users of the dotLRN system
--

create or replace package dotlrn_user
is
 function new (
   user_id		in dotlrn_users.user_id%TYPE,
   role			in dotlrn_users.role%TYPE
 ) return dotlrn_users.user_id%TYPE;
 
 procedure delete (
   user_id		in dotlrn_users.user_id%TYPE
 );
end;
/
show errors


create or replace package body dotlrn_user
is
 function new (
   user_id		in dotlrn_users.user_id%TYPE,
   role			in dotlrn_users.role%TYPE
 ) return dotlrn_users.user_id%TYPE
 is
 begin
   insert into dotlrn_users (user_id, role) values (user_id, role);
   return user_id;
 end;
 
 procedure delete (
   user_id		in dotlrn_users.user_id%TYPE
 )
 is
 begin
   delete from dotlrn_users where user_id= user_id;
 end;

end;
/
show errors



declare
begin
   acs_object_type.create_type (
	    supertype => 'user',
	    object_type => 'dotlrn_user',
	    pretty_name => 'dotLRN User',
	    pretty_plural => 'dotLRN Users',
	    table_name => 'dotlrn_users',
	    id_column => 'user_id',
	    package_name => 'dotlrn_user',
	    name_method => 'acs_object.name'
   );
end;
/
show errors

