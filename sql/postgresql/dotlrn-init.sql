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
-- for PostgreSQL v7.1 and above
--
-- ben@openforce.net
-- September 25th, 2001
-- we remember September 11th, 2001
--

begin
    -- Create the base community type
    select dotlrn_community_type__new(
        'dotlrn_community',
        null,
        'Community',
        'Communities',
        'Communities - the base community type'
    );

    -- create the dotlrn_class community type
    select dotlrn_community_type__new(
        'dotlrn_class_instance',
        'dotlrn_community',
        'Class',
        'Classes',
        'e.g. 6.001'
    );

    -- create the dotlrn_club community type
    dotlrn_community_type__new(
        'dotlrn_club',
        'dotlrn_community',
        'Club',
        'Clubs',
        'e.g. Alumni'
    );

    update acs_object_types set table_name = 'dotlrn_community', package_name = 'dotlrn_community' where object_type = 'dotlrn_community';
    update acs_object_types set table_name = 'dotlrn_class_instance', package_name = 'dotlrn_class_instance' where object_type = 'dotlrn_class_instance';
    update acs_object_types set table_name = 'dotlrn_club', package_name = 'dotlrn_club' where object_type = 'dotlrn_club';

    -- create roles
    acs_rel_type__create_role('student', 'Student', 'Students');
    acs_rel_type__create_role('course_assistant', 'Course Assistant', 'Course Assistants');
    acs_rel_type__create_role('teaching_assistant', 'Teaching Assistant', 'Teaching Assistants');
    acs_rel_type__create_role('instructor', 'Professor', 'Professors');
    acs_rel_type__create_role('course_admin', 'Course Administrator', 'Course Administrators');
    acs_rel_type__create_role('admin', 'Administrator', 'Administrators');
end;
