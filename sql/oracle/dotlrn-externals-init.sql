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
-- Initialize the dotLRN Externals package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
    foo                         integer;
    group_id                    integer;
    dotlrn_users_group_id       integer;
begin

    acs_rel_type.create_type(
        rel_type => 'dotlrn_external_profile_rel',
        supertype => 'dotlrn_user_profile_rel',
        pretty_name => 'dotLRN Profile External',
        pretty_plural => 'dotLRN Profile Externals',
        package_name => 'dotlrn_external_profile_rel',
        table_name => 'dotlrn_external_profile_rels',
        id_column => 'rel_id',
        object_type_one => 'profiled_group',
        role_one => null,
        min_n_rels_one => 0,
        max_n_rels_one => null,
        object_type_two => 'user',
        role_two => null,
        min_n_rels_two => 0,
        max_n_rels_two => 1
    );

    select min(impl_id)
    into foo
    from acs_sc_impls
    where impl_name = 'dotlrn_external_profile_provider';

    group_id := profiled_group.new(
        profile_provider => foo,
        group_name => 'dotLRN Externals'
    );

    insert
    into dotlrn_user_types
    (type, pretty_name, group_id)
    values
    ('external', 'External', group_id);

    foo := rel_segment.new(
        segment_name => 'dotLRN Externals',
        group_id => group_id,
        rel_type => 'dotlrn_external_profile_rel'
    );

    select group_id
    into dotlrn_users_group_id
    from groups
    where group_name = 'dotLRN Users';

    foo := composition_rel.new(
        object_id_one => dotlrn_users_group_id,
        object_id_two => group_id
    );

end;
/
show errors
