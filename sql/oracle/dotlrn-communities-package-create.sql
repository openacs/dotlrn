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

create or replace package dotlrn_community_type
is
    function new (
        community_type in dotlrn_community_types.community_type%TYPE,
        parent_type in dotlrn_community_types.supertype%TYPE default 'dotlrn_community',
        pretty_name in dotlrn_community_types.pretty_name%TYPE,
        pretty_plural in dotlrn_community_types.pretty_name%TYPE default null,
        description in dotlrn_community_types.description%TYPE,
        package_id in dotlrn_community_types.package_id%TYPE default null,
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null,
        context_id in acs_objects.context_id%TYPE default null
    ) return dotlrn_community_types.community_type%TYPE;

    procedure delete (
        community_type in dotlrn_community_types.community_type%TYPE
    );

    function name (
        community_type in dotlrn_community_types.community_type%TYPE
    ) return varchar;
end;
/
show errors

create or replace package body dotlrn_community_type
is
    function new (
        community_type in dotlrn_community_types.community_type%TYPE,
        parent_type in dotlrn_community_types.supertype%TYPE default 'dotlrn_community', 
        pretty_name in dotlrn_community_types.pretty_name%TYPE,
        pretty_plural in dotlrn_community_types.pretty_name%TYPE default null,
        description in dotlrn_community_types.description%TYPE,
        package_id in dotlrn_community_types.package_id%TYPE default null,
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null,
        context_id in acs_objects.context_id%TYPE default null
    ) return dotlrn_community_types.community_type%TYPE
    is
        v_parent_object_type acs_object_types.object_type%TYPE;
        v_unique_name acs_objects.object_id%TYPE;
    begin
        if parent_type is null then
            v_parent_object_type:= 'group';
        else
            v_parent_object_type:= parent_type;
        end if;

        select acs_object_id_seq.nextval
        into v_unique_name
        from dual;

        acs_object_type.create_type (
            supertype => v_parent_object_type,
            object_type => community_type,
            pretty_name => community_type,
            pretty_plural => community_type,
            table_name => v_unique_name,
            id_column => v_unique_name,
            package_name => v_unique_name,
            name_method => 'acs_group.name'
        );

        insert
        into group_types
        (group_type, default_join_policy)
        values
        (community_type, 'closed');

        insert
        into dotlrn_community_types
        (community_type, pretty_name, description, package_id, supertype)
        values
        (community_type, pretty_name, description, package_id, parent_type);

        return community_type;
    end;

    procedure delete (
        community_type in dotlrn_community_types.community_type%TYPE
    )
    is
    begin
        delete
        from dotlrn_community_types
        where community_type = community_type;

        acs_object_type.drop_type(community_type);
    end;

    function name (
        community_type in dotlrn_community_types.community_type%TYPE
    ) return varchar
    is
        name dotlrn_community_types.pretty_name%TYPE;
    begin
        select pretty_name into name
        from dotlrn_community_types;

        return name;
    end;
end;
/
show errors

create or replace package dotlrn_community
is
    function new (
        community_id in dotlrn_communities.community_id%TYPE default null,
        parent_community_id in dotlrn_communities.parent_community_id%TYPE default null,
        community_type in dotlrn_communities.community_type%TYPE,
        community_key in dotlrn_communities.community_key%TYPE,
        pretty_name in dotlrn_communities.pretty_name%TYPE,
        description in dotlrn_communities.description%TYPE,
        portal_id in dotlrn_communities.portal_id%TYPE default null,
        portal_template_id in dotlrn_communities.portal_template_id%TYPE default null,
        package_id in dotlrn_communities.package_id%TYPE default null,
        join_policy in groups.join_policy%TYPE default null,
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null,
        context_id in acs_objects.context_id%TYPE default null
    ) return dotlrn_communities.community_id%TYPE;

    procedure set_active_dates (
        community_id in dotlrn_communities.community_id%TYPE,
        start_date in dotlrn_communities.active_start_date%TYPE,
        end_date in dotlrn_communities.active_end_date%TYPE
    );

    procedure delete (
        community_id in dotlrn_communities.community_id%TYPE
    );

    function name (
        community_id in dotlrn_communities.community_id%TYPE
    ) return varchar; 

    function member_p (
        community_id in dotlrn_communities.community_id%TYPE,
        party_id in parties.party_id%TYPE
    ) return char;

    function admin_p (
        community_id in dotlrn_communities.community_id%TYPE,
        party_id in parties.party_id%TYPE
    ) return char;

    function url (
        community_id in dotlrn_communities.community_id%TYPE
    ) return varchar2;

    function has_subcomm_p (
        community_id in dotlrn_communities.community_id%TYPE
    ) return char;

end dotlrn_community;
/
show errors

create or replace package body dotlrn_community
as
    function new (
        community_id in dotlrn_communities.community_id%TYPE default null,
        parent_community_id in dotlrn_communities.parent_community_id%TYPE default null,
        community_type in dotlrn_communities.community_type%TYPE,
        community_key in dotlrn_communities.community_key%TYPE,
        pretty_name in dotlrn_communities.pretty_name%TYPE,
        description in dotlrn_communities.description%TYPE,
        portal_id in dotlrn_communities.portal_id%TYPE default null,
        portal_template_id in dotlrn_communities.portal_template_id%TYPE default null,
        package_id in dotlrn_communities.package_id%TYPE default null,
        join_policy in groups.join_policy%TYPE default null,
        creation_date in acs_objects.creation_date%TYPE default sysdate,
        creation_user in acs_objects.creation_user%TYPE default null,
        creation_ip in acs_objects.creation_ip%TYPE default null,
        context_id in acs_objects.context_id%TYPE default null
    ) return dotlrn_communities.community_id%TYPE
    is
        c_id integer;
    begin
        c_id := acs_group.new (
            context_id => context_id,
            group_id => community_id,
            object_type => community_type,
            creation_date => creation_date,
            creation_user => creation_user,
            creation_ip => creation_ip,
            group_name => community_key,
            join_policy => join_policy
        );

        insert into dotlrn_communities
          (community_id, 
           parent_community_id,
           community_type, 
           community_key, 
           pretty_name,  
           description, 
           package_id, 
           portal_id, 
           portal_template_id)
        values
          (c_id, 
           parent_community_id, 
           community_type, 
           community_key, 
           pretty_name, 
           description,    
           package_id, 
           portal_id, 
           portal_template_id);

        return c_id;
    end;

    procedure set_active_dates (
        community_id in dotlrn_communities.community_id%TYPE,
        start_date in dotlrn_communities.active_start_date%TYPE,
        end_date in dotlrn_communities.active_end_date%TYPE
    )
    is
    begin
        update dotlrn_communities
        set active_start_date = start_date,
            active_end_date = end_date
        where community_id = set_active_dates.community_id;
    end;

    procedure delete (
        community_id in dotlrn_communities.community_id%TYPE
    )
    is
    begin
        delete
        from dotlrn_communities
        where community_id = community_id;

        acs_group.delete(community_id);
    end;

    function name (
        community_id in dotlrn_communities.community_id%TYPE
    ) return varchar
    is
    begin
        return acs_group.name(community_id);
    end;

    function member_p (
        community_id in dotlrn_communities.community_id%TYPE,
        party_id in parties.party_id%TYPE
    ) return char
    is
        v_member_p              char(1);
    begin
        select decode(count(*), 0, 'f', 't')
        into v_member_p
        from dual
        where exists (select 1
                      from dotlrn_member_rels_approved
                      where dotlrn_member_rels_approved.user_id = party_id
                      and dotlrn_member_rels_approved.community_id = community_id);

        return v_member_p;
    end;

    function admin_p (
        community_id in dotlrn_communities.community_id%TYPE,
        party_id in parties.party_id%TYPE
    ) return char
    is
        v_rv char(1);
    begin
        select decode(
                   acs_permission.permission_p(community_id, party_id, 'dotlrn_admin_community'),
                   'f',
                   acs_permission.permission_p(community_id, party_id, 'admin'),
                   't'
               ) into v_rv
        from dual;

        return v_rv;
    end;

    function url (
        community_id in dotlrn_communities.community_id%TYPE
    ) return varchar2
    is
        v_node_id site_nodes.node_id%TYPE;
    begin
        select site_nodes.node_id into v_node_id
        from dotlrn_communities,
             site_nodes
        where dotlrn_communities.community_id = dotlrn_community.url.community_id
        and site_nodes.object_id = dotlrn_communities.package_id;

        return site_node.url(v_node_id);

        exception
            when no_data_found then
                return '';
    end;

    function has_subcomm_p (
        community_id in dotlrn_communities.community_id%TYPE
    ) return char
    is
        v_rv char(1);
    begin
        select decode(count(*), 0, 'f', 't')
        into v_rv
        from dual
        where exists (select 1
                      from dotlrn_communities
                      where parent_community_id = has_subcomm_p.community_id);
        return v_rv;
    end;

end;
/
show errors

create or replace view dotlrn_communities_full
as
    select dotlrn_communities.*,
           dotlrn_community.url(dotlrn_communities.community_id) as url,
           groups.group_name,
           groups.join_policy
    from dotlrn_communities,
         groups
    where dotlrn_communities.community_id = groups.group_id;

