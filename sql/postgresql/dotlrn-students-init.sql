--
-- Initialize the dotLRN Students package
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
        ''dotlrn_student_profile_rel'',
        ''dotLRN Student Profile Membership'',
        ''dotLRN Student Profile Memberships'',
        ''dotlrn_user_profile_rel'',
        ''dotlrn_student_profile_rels'',
        ''rel_id'',
        ''dotlrn_student_profile_rel'',
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
    where impl_name = ''dotlrn_student_profile_provider'';

    group_id := profiled_group__new(
        foo,
        ''dotLRN Students''
    );

    insert
    into dotlrn_user_types
    (type, pretty_name, group_id)
    values
    (''student'', ''Student'', group_id);

    foo := rel_segment__new(
        ''dotLRN Profiled Students'',
        group_id,
        ''dotlrn_student_profile_rel''
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
        ''dotlrn_full_student_profile_rel'',
        ''dotLRN Full Student Profile Membership'',
        ''dotLRN Full Student Profile Memberships'',
        ''dotlrn_full_user_profile_rel'',
        ''dotlrn_full_student_profile_rels'',
        ''rel_id'',
        ''dotlrn_full_student_profile_rel'',
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
                              where impl_name = ''dotlrn_student_profile_provider'');

    foo := rel_segment__new(
        ''dotLRN Full Profiled Students'',
        foo,
        ''dotlrn_full_student_profile_rel''
    );

end;
' language 'plpgsql';

select inline_2();
drop function inline_2();