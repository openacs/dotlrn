--
-- Initialize the User Profile package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create function inline_1()
returns integer as '
declare
    foo                         integer;
begin

    acs_rel_type.create_type(
        ''dotlrn_user_profile_rel'',
        ''dotLRN User Profile Membership'',
        ''dotLRN User Profile Memberships'',
        ''user_profile_rel'',
        ''dotlrn_user_profile_rels'',
        ''rel_id'',
        ''dotlrn_user_profile_rel'',
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
    where impl_name = ''dotlrn_user_profile_provider'';

    foo := profiled_group__new(
        foo,
        ''dotLRN Users''
    );

    foo := rel_segment__new(
        segment_name => ''dotLRN Profiled Users'',
        group_id => foo,
        rel_type => ''dotlrn_user_profile_rel''
    );

    return(0);
end;
' language 'plpgsql';

select inline_1();
drop function inline_1();


create function inline_2()
returns integer as '
declare
    foo                         integer;
begin
    PERFORM acs_rel_type__create_type(
        ''dotlrn_full_user_profile_rel'',
        ''dotLRN Full User Profile Membership'',
        ''dotLRN Full User Profile Memberships'',
        ''dotlrn_user_profile_rel'',
        ''dotlrn_full_user_profile_rels'',
        ''rel_id'',
        ''dotlrn_full_user_profile_rel'', 
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
                              where impl_name = ''dotlrn_user_profile_provider'');

    foo := rel_segment__new(
        ''dotLRN Full Profiled Users'',
        foo,
        ''dotlrn_full_user_profile_rel''
    );

    return (0);
end;
' language 'plpgsql';

select inline_2();
drop function inline_2();

