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
-- sanitize dotLRN
--
-- @author Ben Adida (ben@openforce.net)
-- @author dan chak (chak@openforce.net)
-- @creation-date 2001-09-25
-- ported 2002-07-01
-- @version $Id$
--
-- @note We remember September 11th, 2001
--

begin

    select acs_rel_type__drop_type(
        'dotlrn_admin_rel',
        't'
    );

    -- all rels to communities must have a portal_id
    select acs_attribute__drop_attribute(
        'dotlrn_member_rel',
        'portal_id'
    );

    -- drop basic rel_types
    select acs_rel_type__drop_type(
        'dotlrn_member_rel',
        't'
    );

    -- drop roles
    select acs_rel_type__drop_role(
        'student'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'student_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'student_pretty_plural'
    );

    select acs_rel_type__drop_role(
        'course_assistant'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'course_assistant_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'course_assistant_pretty_plural'
    );

    select acs_rel_type__drop_role(
        'teaching_assistant'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'teaching_assistant_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'teaching_assistant_pretty_plural'
    );

    select acs_rel_type__drop_role(
        'instructor'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'instructor_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'instructor_pretty_plural'
    );

    select acs_rel_type__drop_role(
        'course_admin'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'course_admin_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'course_admin_pretty_plural'
    );

    select acs_rel_type__drop_role(
        'admin'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'admin_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'admin_pretty_plural'
    );

    -- drop the dotlrn_club community type
    select dotlrn_community_type__delete(
        'dotlrn_club'
    );

    -- drop the dotlrn_class community type
    select dotlrn_community_type__delete(
        'dotlrn_class_instance'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'header_font'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'header_font_size'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'header_font_color'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'header_logo_item_id'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'member_pretty_name'
    );

    select acs_attribute__drop_attribute(
        'dotlrn_community',
        'member_pretty_plural'
    );

    -- drop the base community type
    select dotlrn_community_type__delete(
        'dotlrn_community'
    );

end;
