
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
	year_attr_id acs_attributes.attribute_id$TYPE;
	term_attr_id acs_attributes.attribute_id$TYPE;
begin
	-- create the major group types
	acs_object_type.create_type (
	  supertype => 'group',
	  object_type => 'dotlrn_community',
	  pretty_name => 'dotLRN Community',
	  pretty_plural => 'dotLRN Communities',
	  table_name => 'dotlrn_communities',
	  id_column => 'community_id',
	  package_name => 'dotlrn',
	  type_extension_table => 'dotlrn_community_types',
	  name_method => 'acs_group.name'
	);

	acs_object_type.create_type (
	  supertype => 'dotlrn_community',
	  object_type => 'dotlrn_club',
	  pretty_name => 'dotLRN Club',
	  pretty_plural => 'dotLRN Clubs',
	  table_name => 'dotlrn_clubs',
	  id_column => 'club_id',
	  package_name => 'dotlrn',
	  name_method => 'acs_group.name'
	);

	acs_object_type.create_type (
	  supertype => 'dotlrn_community',
	  object_type => 'dotlrn_class',
	  pretty_name => 'dotLRN Class',
	  pretty_plural => 'dotLRN Classes',
	  table_name => 'dotlrn_classes',
	  id_column => 'class_id',
	  package_name => 'dotlrn',
	  name_method => 'acs_group.name'
	);

	-- year attribute
	year_attr_id:= acs_attribute.create_attribute (
	  object_type => 'dotlrn_class',
	  attribute_name => 'year',
	  datatype => 'string',
	  pretty_name => 'Year',
	  pretty_plural => 'Years',
	  min_n_values => 1,
	  max_n_values => 1
	);

	-- term attribute
	term_attr_id:= acs_attribute.create_attribute (
	  object_type => 'dotlrn_class',
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

	-- create relationships
	acs_rel_type.create_type (
	  rel_type => 'admin_rel',
	  supertype => 'membership_rel',
	  pretty_name => 'Administration Relation',
	  pretty_plural => 'Administration Relationships',
	  package_name => 'dotlrn',
	  object_type_one => 'dotlrn_community', role_one => NULL,
	  min_n_rels_one => 0, max_n_rels_one => null,
	  object_type_two => 'party', role_two => 'admin',
	  min_n_rels_two => 0, max_n_rels_two => null
	);

	acs_rel_type.create_type (
	  rel_type => 'instructor_rel',
	  supertype => 'admin_rel',
	  pretty_name => 'Instructor Relation',
	  pretty_plural => 'Instructor Relationships',
	  package_name => 'dotlrn',
	  object_type_one => 'dotlrn_class', role_one => NULL,
	  min_n_rels_one => 0, max_n_rels_one => null,
	  object_type_two => 'party', role_two => 'instructor',
	  min_n_rels_two => 0, max_n_rels_two => null
	);

	acs_rel_type.create_type (
	  rel_type => 'ta_rel',
	  supertype => 'admin_rel',
	  pretty_name => 'TA Relation',
	  pretty_plural => 'TA Relationships',
	  package_name => 'dotlrn',
	  object_type_one => 'dotlrn_class', role_one => NULL,
	  min_n_rels_one => 0, max_n_rels_one => null,
	  object_type_two => 'party', role_two => 'teaching_assistant',
	  min_n_rels_two => 0, max_n_rels_two => null
	);

	acs_rel_type.create_type (
	  rel_type => 'student_rel',
	  supertype => 'membership_rel',
	  pretty_name => 'Student Relation',
	  pretty_plural => 'Student Relationships',
	  package_name => 'dotlrn',
	  object_type_one => 'dotlrn_class', role_one => NULL,
	  min_n_rels_one => 0, max_n_rels_one => null,
	  object_type_two => 'party', role_two => 'student',
	  min_n_rels_two => 0, max_n_rels_two => null
	);
	
end;
/
show errors

