--
-- Sanitize the dotLRN Professor package
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
    where segment_name = 'dotLRN Full Profiled Professors';

    rel_segment.delete(
        segment_id => foo
    );

    acs_rel_type.drop_type(
        rel_type => 'dotlrn_full_professor_profile_rel',
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
    where segment_name = 'dotLRN Profiled Professors';

    rel_segment.delete(
        segment_id => foo
    );

    select min(group_id)
    into foo
    from profiled_groups
    where profile_provider = (select min(impl_id)
                              from acs_sc_impls
                              where impl_name = 'dotlrn_professor_profile_provider');

    delete
    from dotlrn_user_types
    where group_id = foo;

    profiled_group.delete(
        group_id => foo
    );

    acs_rel_type.drop_type(
        rel_type => 'dotlrn_professor_profile_rel',
        cascade_p => 't'
    );

end;
/
show errors
