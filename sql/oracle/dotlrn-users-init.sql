--
-- Initialize the User Profile package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

declare
    foo                         integer;
begin

    acs_rel_type.create_type(
        rel_type => 'dotlrn_user_profile_rel',
        supertype => 'user_profile_rel',
        pretty_name => 'dotLRN User Profile Membership',
        pretty_plural => 'dotLRN User Profile Memberships',
        package_name => 'dotlrn_user_profile_rel',
        table_name => 'dotlrn_user_profile_rels',
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
    where impl_name = 'dotlrn_user_profile_provider';

    foo := profiled_group.new(
        profile_provider => foo,
        group_name => 'dotLRN Users'
    );

    foo := rel_segment.new(
        segment_name => 'dotLRN Profiled Users',
        group_id => foo,
        rel_type => 'dotlrn_user_profile_rel'
    );

end;
/
show errors

declare
    foo                         integer;
begin

    acs_rel_type.create_type(
        rel_type => 'dotlrn_full_user_profile_rel',
        supertype => 'dotlrn_user_profile_rel',
        pretty_name => 'dotLRN Full User Profile Membership',
        pretty_plural => 'dotLRN Full User Profile Memberships',
        package_name => 'dotlrn_full_user_profile_rel',
        table_name => 'dotlrn_full_user_profile_rels',
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

    select min(group_id)
    into foo
    from profiled_groups
    where profile_provider = (select min(impl_id)
                              from acs_sc_impls
                              where impl_name = 'dotlrn_user_profile_provider');

    foo := rel_segment.new(
        segment_name => 'dotLRN Full Profiled Users',
        group_id => foo,
        rel_type => 'dotlrn_full_user_profile_rel'
    );

end;
/
show errors
