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
-- Sanitize the User Profile package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
    foo                         integer;
begin

    select min(segment_id)
    into foo
    from rel_segments
    where segment_name = 'dotLRN Full Profiled Users';

    rel_segment.delete(
        segment_id => foo
    );

    acs_rel_type.drop_type(
        rel_type => 'dotlrn_full_user_profile_rel',
        cascade_p => 't'
    );

end;
/
show errors

declare
    foo                         integer;
begin

    select min(segment_id)
    into foo
    from rel_segments
    where segment_name = 'dotLRN Profiled Users';

    rel_segment.delete(
        segment_id => foo
    );

    select min(group_id)
    into foo
    from profiled_groups
    where profile_provider = (select min(impl_id)
                              from acs_sc_impls
                              where impl_name = 'dotlrn_user_profile_provider');

    profiled_group.delete(
        group_id => foo
    );

    acs_rel_type.drop_type(
        rel_type => 'dotlrn_user_profile_rel',
        cascade_p => 't'
    );

end;
/
show errors
