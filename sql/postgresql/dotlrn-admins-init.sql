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
-- Initialize the dotLRN Admins package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--


create function inline_1()
returns integer as '
declare
    foo                         integer;
    group_id                    integer;
    dotlrn_users_group_id       integer;
begin

    PERFORM acs_rel_type__create_type(
        ''dotlrn_admin_profile_rel'',
        ''dotLRN Admin Profile Membership'',
        ''dotLRN Admin Profile Memberships'',
        ''dotlrn_user_profile_rel'',
        ''dotlrn_admin_profile_rels'',
        ''rel_id'',
        ''dotlrn_admin_profile_rel'',
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
    where impl_name = ''dotlrn_admin_profile_provider'';

    group_id := profiled_group__new(
        foo,
        ''dotLRN Admins''
    );

    insert
    into dotlrn_user_types
    (type, pretty_name, group_id)
    values
    (''admin'', ''Staff'', group_id);

    foo := rel_segment__new(
        ''dotLRN Profiled Admins'',
        group_id,
        ''dotlrn_admin_profile_rel''
    );

    select group_id
    into dotlrn_users_group_id
    from groups
    where group_name = ''dotLRN Users'';

    foo := composition_rel__new(
        dotlrn_users_group_id,
        group_id
    );

end;
' language 'plpgsql';

select inline_1();
drop function inline_1();


create function inline_2()
returns integer as '
declare
    foo                         integer;
begin
    PERFORM acs_rel_type--create_type(
        ''dotlrn_full_admin_profile_rel'',
        ''dotLRN Full Admin Profile Membership'',
        ''dotLRN Full Admin Profile Memberships'',
        ''dotlrn_full_user_profile_rel'',
        ''dotlrn_full_admin_profile_rels'',
        ''rel_id'',
        ''dotlrn_full_admin_profile_rel'',
        ''profiled_group'',
        null,
        0,
        null,
        ''user'',
        null,
        0,
        1
    );

    select min(group_id)
    into foo
    from profiled_groups
    where profile_provider = (select min(impl_id)
                              from acs_sc_impls
                              where impl_name = ''dotlrn_admin_profile_provider'');

    foo := rel_segment__new(
        ''dotLRN Full Profiled Admins'',
        foo,
        ''dotlrn_full_admin_profile_rel''
    );

end;
' language 'plpgsql';

select inline_2();
drop function inline_2();
