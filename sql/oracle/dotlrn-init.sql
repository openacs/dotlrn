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
    foo dotlrn_community_types.community_type%TYPE;
begin
    -- Create the base community type
    foo := dotlrn_community_type.new (
        community_type => 'dotlrn_community',
        parent_type => null,
        pretty_name => 'Community',
        pretty_plural => 'Communities',
        description => 'Communities - the base community type'
    );

    -- create the dotlrn_class community type
    foo := dotlrn_community_type.new (
        community_type => 'dotlrn_class_instance',
        parent_type => 'dotlrn_community',
        pretty_name => 'Class',
        pretty_plural => 'Classes',
        description => 'e.g. 6.001'
    );

    -- create the dotlrn_club community type
    foo := dotlrn_community_type.new (
        community_type => 'dotlrn_club',
        parent_type => 'dotlrn_community',
        pretty_name => 'Club',
        pretty_plural => 'Clubs',
        description => 'e.g. Alumni'
    );

    update acs_object_types set table_name = 'dotlrn_community', package_name = 'dotlrn_community' where object_type = 'dotlrn_community';
    update acs_object_types set table_name = 'dotlrn_class_instance', package_name = 'dotlrn_class_instance' where object_type = 'dotlrn_class_instance';
    update acs_object_types set table_name = 'dotlrn_club', package_name = 'dotlrn_club' where object_type = 'dotlrn_club';

    -- create roles
    acs_rel_type.create_role ('student', 'Student', 'Students');
    acs_rel_type.create_role ('course_assistant', 'Course Assistant', 'Course Assistants');
    acs_rel_type.create_role ('teaching_assistant', 'Teaching Assistant', 'Teaching Assistants');
    acs_rel_type.create_role ('instructor', 'Professor', 'Professors');
    acs_rel_type.create_role ('course_admin', 'Course Administrator', 'Course Administrators');
    acs_rel_type.create_role ('admin', 'Administrator', 'Administrators');
end;
/
show errors


--
-- Object Types and Attributes
--

declare
    foo        integer;
begin
    acs_rel_type.create_type (
        rel_type => 'dotlrn_member_rel',
        supertype => 'membership_rel',
        pretty_name => 'dotLRN Community Membership',
        pretty_plural => 'dotLRN Community Memberships',
        package_name => 'dotlrn_member_rel',
        table_name => 'dotlrn_member_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_community', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'member',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    acs_rel_type.create_type (
        rel_type => 'dotlrn_admin_rel',
        supertype => 'dotlrn_member_rel',
        pretty_name => 'dotLRN Admin Community Membership',
        pretty_plural => 'dotLRN Admin Community Memberships',
        package_name => 'dotlrn_admin_rel',
        table_name => 'dotlrn_admin_rels',        
        id_column => 'rel_id',
        object_type_one => 'dotlrn_community', role_one => null, 
        min_n_rels_one => 0, max_n_rels_one => null,
        object_type_two => 'user', role_two => 'admin',
        min_n_rels_two => 0, max_n_rels_two => null
    );

    --
    -- and now for the attributes
    --
    foo:= acs_attribute.create_attribute (
        object_type => 'dotlrn_member_rel',
        attribute_name => 'portal_id',
        datatype => 'integer',
        pretty_name => 'Page ID',
        pretty_plural => 'Page IDs'
    );
end;
/
show errors
