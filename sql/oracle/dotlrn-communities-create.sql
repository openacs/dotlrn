--
-- The DotLRN communities construct
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net
-- @author arjun (arjun@openforce.net)
-- @creation-date September 20th, 2001 (redone)
-- @version $Id$
--

create table dotlrn_community_types (
    community_type              constraint dotlrn_ct_community_type_fk
                                references group_types (group_type)
                                constraint dotlrn_community_types_pk
                                primary key,
    pretty_name                 varchar2(100)
                                constraint dotlrn_ct_pretty_name_nn
                                not null,
    description                 varchar2(4000),
    package_id                  constraint dotlrn_ct_package_id_fk
                                references apm_packages (package_id),
    supertype                   constraint dotlrn_ct_supertype_fk
                                references dotlrn_community_types (community_type)
);

create table dotlrn_communities (
    community_id                constraint dotlrn_c_community_id_fk
                                references groups (group_id)
                                constraint dotlrn_communities_pk
                                primary key,
    parent_community_id         constraint dotlrn_c_parent_comm_id_fk
                                references dotlrn_communities (community_id),
    community_type              not null
                                constraint dotlrn_c_community_type_fk
                                references dotlrn_community_types (community_type),
    community_key               varchar2(100)
                                constraint dotlrn_c_community_key_nn
                                not null,
    pretty_name                 varchar2(100)
                                constraint dotlrn_c_pretty_name_nn
                                not null,
    description                 varchar2(4000),
    active_start_date           date,
    active_end_date             date,
    portal_id                   constraint dotlrn_c_portal_id_fk
                                references portals (portal_id),
    admin_portal_id             constraint dotlrn_c_admin_portal_id_fk
                                references portals (portal_id),
    portal_template_id          constraint dotlrn_c_portal_template_id_fk
                                references portals (portal_id),
    package_id                  constraint dotlrn_c_package_id_fk
                                references apm_packages (package_id),
    -- We can't have two communities with the same parent with the same key (url)
    -- even if the parent_community_id is null, which it will be for non-subcommunities
    constraint dotlrn_c_community_key_un
    unique (community_key, parent_community_id)
);

create or replace view dotlrn_communities_full
as
    select dotlrn_communities.*,
           groups.group_name,
           groups.join_policy
    from dotlrn_communities,
         groups
    where dotlrn_communities.community_id = groups.group_id;

create or replace view dotlrn_communities_not_closed
as
    select dotlrn_communities.*,
           groups.join_policy
    from dotlrn_communities,
         groups
    where dotlrn_communities.community_id = groups.group_id
    and groups.join_policy <> 'closed';

create or replace view dotlrn_active_communities
as
    select *
    from dotlrn_communities
    where (active_start_date is null or active_start_date < sysdate)
    and (active_end_date is null or active_end_date > sysdate);

create or replace view dotlrn_active_comms_not_closed
as
    select dotlrn_communities.*,
           groups.join_policy
    from dotlrn_active_communities dotlrn_communities,
         groups
    where dotlrn_communities.community_id = groups.group_id
    and groups.join_policy <> 'closed';

create table dotlrn_applets (
    applet_id                   integer
                                constraint dotlrn_applets_applet_id_nn
                                not null
                                constraint dotlrn_applets_applet_pk 
                                primary key,
    applet_key                  varchar(100)
                                constraint dotlrn_applets_applet_key_nn
                                not null
                                constraint dotlrn_applets_applet_key_uk
                                unique,
    status                      char(10)
                                default 'active'
                                constraint dotlrn_applets_status_nn
                                not null
                                constraint dotlrn_applets_status_ck
                                check (status in ('active','inactive'))
);

create table dotlrn_community_applets (
    community_id                integer
                                constraint dotlrn_ca_community_id_nn
                                not null
                                constraint dotlrn_ca_community_id_fk
                                references dotlrn_communities (community_id),
    applet_id                   integer
                                constraint dotlrn_ca_applet_key_nn
                                not null
                                references dotlrn_applets (applet_id),
    constraint dotlrn_community_applets_pk primary key (community_id, applet_id),
    -- this is the package_id of the package this applet represents
    package_id                  integer,
    active_p                    char(1)
                                default 't'
                                constraint dotlrn_ca_active_p_nn
                                not null
                                constraint dotlrn_ca_active_p_ck
                                check (active_p in ('t','f'))
);

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
    begin
        if parent_type is null then
            v_parent_object_type:= 'group';
        else
            v_parent_object_type:= parent_type;
        end if;

        acs_object_type.create_type (
            supertype => v_parent_object_type,
            object_type => community_type,
            pretty_name => pretty_name,
            pretty_plural => pretty_plural,
            table_name => community_type,
            id_column => 'XXX',
            package_name => community_type,
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
    begin
        -- TODO: a-la aD, implement this for real (bma)
        return 't';
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
end;
/
show errors
