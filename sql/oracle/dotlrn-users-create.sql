
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

create table dotlrn_users (
       user_id		  integer not null
			  constraint dlrn_user_id_fk
			  references users(user_id)
			  constraint dlrn_user_id_pk
			  primary key,
       role		  varchar(100) not null,
       page_id		  integer 
			  constraint dlrn_user_page_id_fk
			  references portals(portal_id)
);


create view dotlrn_users_full as select registered_users.user_id, first_names, last_name, email, role, page_id from dotlrn_users, registered_users where dotlrn_users.user_id= registered_users.user_id;


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

