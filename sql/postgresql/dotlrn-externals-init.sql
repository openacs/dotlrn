--
-- Initialize the dotLRN Externals package
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
        ''dotlrn_external_profile_rel'',
        ''dotLRN External Profile Membership'',
        ''dotLRN External Profile Memberships'',
        ''dotlrn_user_profile_rel'',
        ''dotlrn_external_profile_rels'',
        ''rel_id'',
        ''dotlrn_external_profile_rel'',
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
    where impl_name = ''dotlrn_external_profile_provider'';

    group_id := profiled_group__new(
        foo,
        ''dotLRN Externals''
    );

    insert
    into dotlrn_user_types
    (type, pretty_name, group_id)
    values
    (''external'', ''External'', group_id);

    foo := rel_segment__new(
        ''dotLRN Profiled Externals'',
        group_id,
        ''dotlrn_external_profile_rel''
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
        ''dotlrn_full_external_profile_rel'',
        ''dotLRN Full External Profile Membership'',
        ''dotLRN Full External Profile Memberships'',
        ''dotlrn_full_user_profile_rel'',
        ''dotlrn_full_external_profile_rels'',
        ''rel_id'',
        ''dotlrn_full_external_profile_rel'',
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
                              where impl_name = ''dotlrn_external_profile_provider'');

    foo := rel_segment__new(
        ''dotLRN Full Profiled Externals'',
        foo,
        ''dotlrn_full_external_profile_rel''
    );

end;
' language 'plpgsql';

select inline_2();
drop function inline_2();