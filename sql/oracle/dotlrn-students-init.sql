--
-- Initialize the dotLRN Students package
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
        rel_type => 'dotlrn_student_profile_rel',
        supertype => 'dotlrn_user_profile_rel',
        pretty_name => 'dotLRN Student Profile Membership',
        pretty_plural => 'dotLRN Student Profile Memberships',
        package_name => 'dotlrn_student_profile_rel',
        table_name => 'dotlrn_student_profile_rels',
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
    where impl_name = 'dotlrn_student_profile_provider';

    group_id := profiled_group.new(
        profile_provider => foo,
        group_name => 'dotLRN Students'
    );

    insert
    into dotlrn_user_types
    (type, pretty_name, group_id)
    values
    ('student', 'Student', group_id);

    foo := rel_segment.new(
        segment_name => 'dotLRN Profiled Students',
        group_id => group_id,
        rel_type => 'dotlrn_student_profile_rel'
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

declare
    foo                         integer;
begin

    acs_rel_type.create_type(
        rel_type => 'dotlrn_full_student_profile_rel',
        supertype => 'dotlrn_full_user_profile_rel',
        pretty_name => 'dotLRN Full Student Profile Membership',
        pretty_plural => 'dotLRN Full Student Profile Memberships',
        package_name => 'dotlrn_full_stud_profile_rel',
        table_name => 'dotlrn_full_stud_profile_rels',
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
                              where impl_name = 'dotlrn_student_profile_provider');

    foo := rel_segment.new(
        segment_name => 'dotLRN Full Profiled Students',
        group_id => foo,
        rel_type => 'dotlrn_full_student_profile_rel'
    );

end;
/
show errors