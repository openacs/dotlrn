
--
-- The DotLRN basic system
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- ben@openforce.net
-- September 25th, 2001
-- we remember September 11th, 2001
--


declare
	year_attr_id acs_attributes.attribute_id%TYPE;
	term_attr_id acs_attributes.attribute_id%TYPE;
	foo dotlrn_community_types.community_type%TYPE;
begin
	-- Create the base community type
	foo := dotlrn_community_type.new (
	  community_type => 'dotlrn_community',
	  parent_type => NULL,
	  pretty_name => 'dotLRN Community',
	  pretty_plural => 'dotLRN Communities',
	  description => 'dotLRN Communities - the base community type'
        );

	-- create the dotlrn_class community type
	foo := dotlrn_community_type.new (
	  community_type => 'dotlrn_class_instance',
	  parent_type => 'dotlrn_community',
	  pretty_name => 'dotLRN Class',
	  pretty_plural => 'dotLRN Classes',
	  description => 'dotLRN Classes - e.g. 6.001'
        );

	-- create the dotlrn_club community type
	foo := dotlrn_community_type.new (
	  community_type => 'dotlrn_club',
	  parent_type => 'dotlrn_community',
	  pretty_name => 'dotLRN Club',
	  pretty_plural => 'dotLRN Clubs',
	  description => 'dotLRN Clubs - e.g. Alumni'
        );

	-- year attribute
	year_attr_id:= acs_attribute.create_attribute (
	  object_type => 'dotlrn_class_instance',
	  attribute_name => 'year',
	  datatype => 'string',
	  pretty_name => 'Year',
	  pretty_plural => 'Years',
	  min_n_values => 1,
	  max_n_values => 1
	);

	-- term attribute
	term_attr_id:= acs_attribute.create_attribute (
	  object_type => 'dotlrn_class_instance',
	  attribute_name => 'term',
	  datatype => 'string',
	  pretty_name => 'Term',
	  pretty_plural => 'Terms',
	  min_n_values => 1,
	  max_n_values => 1
	);
		
	-- create roles
	acs_rel_type.create_role ('student', 'Student', 'Students');
	acs_rel_type.create_role ('teaching_assistant', 'Teaching Assistant', 'Teaching Assistants');
	acs_rel_type.create_role ('instructor', 'Instructor', 'Instructors');
	acs_rel_type.create_role ('admin', 'Administrator', 'Administrators');
	
	-- add the user types
	insert into dotlrn_user_types (type_id, type) values (1, 'student');	
	insert into dotlrn_user_types (type_id, type) values (2, 'professor');	
	insert into dotlrn_user_types (type_id, type) values (3, 'admin');	
end;
/
show errors

