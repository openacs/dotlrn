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
-- Initialize the dotLRN Professors package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--


create function inline_1()
returns integer as '
declare
    foo                         integer;
    gid				integer;
    dotlrn_users_group_id       integer;
begin

    PERFORM acs_rel_type__create_type(
        ''dotlrn_professor_profile_rel'',
        ''dotLRN Professor Profile Professor'',
        ''dotLRN Professor Profile Professors'',
	''dotlrn_user_profile_rel'',
        ''dotlrn_professor_profile_rels'',
        ''rel_id'',
        ''dotlrn_professor_profile_rel'',
        ''profiled_group'',
        null,
        0,
        null,
        ''user'',
        null,
        0,
        1
    );

    select min(impl_id)
    into foo
    from acs_sc_impls
    where impl_name = ''dotlrn_professor_profile_provider'';

    gid := profiled_group__new(
        foo,
        ''dotLRN Professors''
    );

    insert
    into dotlrn_user_types
    (type, pretty_name, group_id)
    values
    (''professor'', ''Professor'', gid);

    foo := rel_segment__new(
        ''dotLRN Professors'',
        gid,
        ''dotlrn_professor_profile_rel''
    );

    select group_id
    into dotlrn_users_group_id
    from groups
    where group_name = ''dotLRN Users'';

    foo := composition_rel__new(
        dotlrn_users_group_id,
        gid
    );

    return 0;

end;
' language 'plpgsql';

select inline_1();
drop function inline_1();
