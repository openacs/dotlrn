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
-- @author Ben Adida (ben@openforce.net)
-- @author dan chak (chak@openforce.net)
-- @creation-date 2001-09-25
-- @version $Id$
--
-- @note We remember September 11th, 2001
--

create function inline_0()
returns integer as '
begin

    -- Create the base community type
    perform dotlrn_community_type__new(
        ''dotlrn_community'',
        null,
        ''Community'',
        ''Communities'',
        ''Communities - the base community type''
    );

    -- these are the possible attributes of a community
    perform acs_attribute__create_attribute(
	   ''dotlrn_community'',
	   ''header_font'',
	   ''string'',
	   ''Header Font'',
	   ''Header Fonts'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_attribute(
	   ''dotlrn_community'',
	   ''header_font_size'',
	   ''string'',
	   ''Header Fon Sizet'',
	   ''Header Fonts Sizes'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_attribute(
	   ''dotlrn_community'',
	   ''header_font_color'',
	   ''string'',
	   ''Header Font Color'',
	   ''Header Fonts Colors'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_attribute(
	   ''dotlrn_community'',
	   ''header_logo_item_id'',
	   ''integer'',
	   ''Header Logo Item ID'',
	   ''Header Logo Item ID'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_attribute(
	   ''dotlrn_community'',
	   ''header_logo_alt_text'',
	   ''integer'',
	   ''Header Logo Alt Text'',
	   ''Header Logo Alt Text'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );


    -- create the dotlrn_class community type
    perform dotlrn_community_type__new(
        ''dotlrn_class_instance'',
        ''dotlrn_community'',
        ''Class'',
        ''Classes'',
        ''e.g. 6.001''
    );

    -- create the dotlrn_club community type
    dotlrn_community_type__new(
        ''dotlrn_club'',
        ''dotlrn_community'',
        ''Club'',
        ''Clubs'',
        ''e.g. Alumni''
    );

    update acs_object_types set table_name = ''dotlrn_community'', package_name = ''dotlrn_community'' where object_type = ''dotlrn_community'';
    update acs_object_types set table_name = ''dotlrn_class_instance'', package_name = ''dotlrn_class_instance'' where object_type = ''dotlrn_class_instance'';
    update acs_object_types set table_name = ''dotlrn_club'', package_name = ''dotlrn_club'' where object_type = ''dotlrn_club'';

    perform acs_attribute__create_atribute(
	   ''dotlrn_community'',
	   ''member_pretty_name'',
	   ''string'',
	   ''Member Pretty Name'',
	   ''Member Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute(
	   ''dotlrn_community'',
	   ''member_pretty_plural'',
	   ''string'',
	   ''Member Pretty Plural'',
	   ''Member Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    -- create roles
    perform acs_rel_type__create_role(''student'', ''Student'', ''Students'');
    perform acs_rel_type__create_role(''course_assistant'', ''Course Assistant'', ''Course Assistants'');
    perform acs_rel_type__create_role(''teaching_assistant'', ''Teaching Assistant'', ''Teaching Assistants'');
    perform acs_rel_type__create_role(''instructor'', ''Professor'', ''Professors'');
    perform acs_rel_type__create_role(''course_admin'', ''Course Administrator'', ''Course Administrators'');
    perform acs_rel_type__create_role(''admin'', ''Administrator'', ''Administrators'');

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''student_pretty_name'',
	   ''string'',
	   ''Student Pretty Name'',
	   ''Student Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''student_pretty_plural'',
	   ''string'',
	   ''Student Pretty Plural'',
	   ''Student Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''course_assistant_pretty_name'',
	   ''string'',
	   ''Course Assistant Pretty Name'',
	   ''Course Assistant Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''course_assistant_pretty_plural'',
	   ''string'',
	   ''Course Assistant Pretty Plural'',
	   ''Course Assistant Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''teaching_assistant_pretty_name'',
	   ''string'',
	   ''Teaching Assistant Pretty Name'',
	   ''Teaching Assistant Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''teaching_assistant_pretty_plural'',
	   ''string'',
	   ''Teaching Assistant Pretty Plural'',
	   ''Teaching Assistant Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''instructor_pretty_name'',
	   ''string'',
	   ''Professor Pretty Name'',
	   ''Professor Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''instructor_pretty_plural'',
	   ''string'',
	   ''Professor Pretty Plural'',
	   ''Professor Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''course_admin_pretty_name'',
	   ''string'',
	   ''Course Administrator Pretty Name'',
	   ''Course Administrator Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''course_admin_pretty_plural'',
	   ''string'',
	   ''Course Administrator Pretty Plural'',
	   ''Course Administrator Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',		  
	   ''admin_pretty_name'',
	   ''string'',
	   ''Administrator Pretty Name'',
	   ''Administrator Pretty Name'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    perform acs_attribute__create_atribute (
	   ''dotlrn_community'',
	   ''admin_pretty_plural'',
	   ''string'',
	   ''Administrator Pretty Plural'',
	   ''Administrator Pretty Plural'',
	   null, null, null,
	   0,
	   1,
	   ''generic'',
	   ''f''
    );

    -- create basic rel_types

    perform acs_rel_type__create_type (
	   ''dotlrn_member_rel'',
	   ''dotLRN Community Membership'',
	   ''dotLRN Community Memberships'',
	   ''membership_rel'',
	   ''dotlrn_member_rels'',
	   ''red_id'',
	   ''dotlrn_member_rel'',
	   ''dotlrn_community'',
	   null,
	   0,
	   null,
	   ''user'',
	   ''member'',
	   0,
	   null
    );

    perform acs_rel_type__create_type (
	   ''dotlrn_admin_rel'',
	   ''dotLRN Admin Community Membership'',
	   ''dotLRN Admin Community Memberships'',
	   ''dotlrn_member_rel'',
	   ''dotlrn_admin_rels'',
	   ''red_id'',
	   ''dotlrn_admin_rel'',
	   ''dotlrn_community'',
	   null,
	   0,
	   null,
	   ''user'',
	   ''admin'',
	   0,
	   null
    );

    -- all rels to communities must have a portal_id
    perform acs_attribute__create_atribute (
	  ''dotlrn_member_rel'',
	  ''portal_id'',
	  ''integer'',
	  ''Page ID'',
	  ''Page IDs''
	  null, null, null,
	  1,
	  1,
	  null,
	  ''type_specific'',
	  ''f''
    );

    return 0;
end;' language 'plpgsql';

select inline_0();
drop function inline_0();
