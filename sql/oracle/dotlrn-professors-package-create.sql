--
-- Create the Professor package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

create or replace package dotlrn_professor_profile_rel
as
    function new (
        rel_id in dotlrn_professor_profile_rels.rel_id%TYPE default null,
        id in dotlrn_user_profile_rels.id%TYPE default null,
        rel_type in acs_rels.rel_type%TYPE default 'dotlrn_professor_profile_rel',
        group_id in groups.group_id%TYPE default null,
        user_id in users.user_id%TYPE,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null
    ) return dotlrn_user_profile_rels.rel_id%TYPE;

    procedure delete (
        rel_id in dotlrn_professor_profile_rels.rel_id%TYPE
    );

end;
/
show errors

create or replace package body dotlrn_professor_profile_rel
as
    function new (
        rel_id in dotlrn_professor_profile_rels.rel_id%TYPE default null,
        id in dotlrn_user_profile_rels.id%TYPE default null,
        rel_type in acs_rels.rel_type%TYPE default 'dotlrn_professor_profile_rel',
        group_id in groups.group_id%TYPE default null,
        user_id in users.user_id%TYPE,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null
    ) return dotlrn_user_profile_rels.rel_id%TYPE
    is
        v_rel_id                dotlrn_user_profile_rels.rel_id%TYPE;
        v_group_id              groups.group_id%TYPE;
    begin
        if group_id is null then
            select min(group_id)
            into v_group_id
            from profiled_groups
            where profile_provider = (select min(impl_id)
                                      from acs_sc_impls
                                      where impl_name = 'dotlrn_professor_profile_provider');
        else
             v_group_id := group_id;
        end if;

        v_rel_id := dotlrn_user_profile_rel.new(
            rel_id => rel_id,
            id => id,
            rel_type => rel_type,
            group_id => v_group_id,
            user_id => user_id,
            creation_user => creation_user,
            creation_ip => creation_ip
        );

        insert
        into dotlrn_professor_profile_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
    end;

    procedure delete (
        rel_id in dotlrn_professor_profile_rels.rel_id%TYPE
    )
    is
    begin
        delete
        from dotlrn_professor_profile_rels
        where rel_id = dotlrn_professor_profile_rel.delete.rel_id;

        dotlrn_user_profile_rel.delete(rel_id);
    end;

end;
/
show errors

create or replace package dotlrn_full_prof_profile_rel
as
    function new (
        rel_id in dotlrn_full_prof_profile_rels.rel_id%TYPE default null,
        portal_id in dotlrn_full_user_profile_rels.portal_id%TYPE,
        theme_id in dotlrn_full_user_profile_rels.theme_id%TYPE default null,
        id in dotlrn_user_profile_rels.id%TYPE default null,
        rel_type in acs_rels.rel_type%TYPE default 'dotlrn_full_professor_profile_rel',
        group_id in groups.group_id%TYPE default null,
        user_id in users.user_id%TYPE,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null
    ) return dotlrn_full_user_profile_rels.rel_id%TYPE;

    procedure delete (
        rel_id in dotlrn_full_prof_profile_rels.rel_id%TYPE
    );

end;
/
show errors

create or replace package body dotlrn_full_prof_profile_rel
as
    function new (
        rel_id in dotlrn_full_prof_profile_rels.rel_id%TYPE default null,
        portal_id in dotlrn_full_user_profile_rels.portal_id%TYPE,
        theme_id in dotlrn_full_user_profile_rels.theme_id%TYPE default null,
        id in dotlrn_user_profile_rels.id%TYPE default null,
        rel_type in acs_rels.rel_type%TYPE default 'dotlrn_full_professor_profile_rel',
        group_id in groups.group_id%TYPE default null,
        user_id in users.user_id%TYPE,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null
    ) return dotlrn_full_user_profile_rels.rel_id%TYPE
    is
        v_rel_id                dotlrn_full_user_profile_rels.rel_id%TYPE;
        v_group_id              groups.group_id%TYPE;
    begin
        if group_id is null then
            select min(group_id)
            into v_group_id
            from profiled_groups
            where profile_provider = (select min(impl_id)
                                      from acs_sc_impls
                                      where impl_name = 'dotlrn_professor_profile_provider');
        else
             v_group_id := group_id;
        end if;

        v_rel_id := dotlrn_full_user_profile_rel.new(
            rel_id => rel_id,
            portal_id => portal_id,
            theme_id => theme_id,
            id => id,
            rel_type => rel_type,
            group_id => v_group_id,
            user_id => user_id,
            creation_user => creation_user,
            creation_ip => creation_ip
        );

        insert
        into dotlrn_full_prof_profile_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
    end;

    procedure delete (
        rel_id in dotlrn_full_prof_profile_rels.rel_id%TYPE
    )
    is
    begin
        delete
        from dotlrn_full_prof_profile_rels
        where rel_id = dotlrn_full_prof_profile_rel.delete.rel_id;

        dotlrn_full_user_profile_rel.delete(rel_id);
    end;

end;
/
show errors
