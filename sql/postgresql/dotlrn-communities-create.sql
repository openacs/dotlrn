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
-- The DotLRN communities construct
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for PG
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net
-- @author arjun (arjun@openforce.net)
-- @creation-date September 20th, 2001 (redone)
-- @version $Id$
--

create table dotlrn_community_types (
    community_type              varchar(100) constraint dotlrn_ct_community_type_fk
                                references group_types (group_type)
                                constraint dotlrn_community_types_pk
                                primary key,
    pretty_name                 varchar(100)
                                constraint dotlrn_ct_pretty_name_nn
                                not null,
    description                 varchar(4000),
    package_id                  integer
                                constraint dotlrn_ct_package_id_fk
                                references apm_packages (package_id),
    supertype                   varchar(100) constraint dotlrn_ct_supertype_fk
                                references dotlrn_community_types (community_type)
);

create table dotlrn_communities (
    community_id                integer constraint dotlrn_c_community_id_fk
                                references groups (group_id)
                                constraint dotlrn_communities_pk
                                primary key,
    parent_community_id         integer constraint dotlrn_c_parent_comm_id_fk
                                references dotlrn_communities (community_id),
    community_type              varchar(100) not null
                                constraint dotlrn_c_community_type_fk
                                references dotlrn_community_types (community_type),
    community_key               varchar(100)
                                constraint dotlrn_c_community_key_nn
                                not null,
    pretty_name                 varchar(100)
                                constraint dotlrn_c_pretty_name_nn
                                not null,
    description                 varchar(4000),
    active_start_date           date,
    active_end_date             date,
    portal_id                   integer constraint dotlrn_c_portal_id_fk
                                references portals (portal_id),
    admin_portal_id             integer constraint dotlrn_c_admin_portal_id_fk
                                references portals (portal_id),
    portal_template_id          integer constraint dotlrn_c_portal_template_id_fk
                                references portals (portal_id),
    package_id                  integer constraint dotlrn_c_package_id_fk
                                references apm_packages (package_id),
    -- We can't have two communities with the same parent with the same key (url)
    -- even if the parent_community_id is null, which it will be for non-subcommunities
    constraint dotlrn_c_community_key_un
    unique (community_key, parent_community_id)
);

create view dotlrn_communities_not_closed
as
    select dotlrn_communities.*,
           groups.join_policy
    from dotlrn_communities,
         groups
    where dotlrn_communities.community_id = groups.group_id
    and groups.join_policy <> 'closed';

create view dotlrn_active_communities
as
    select *
    from dotlrn_communities
    where (active_start_date is null or active_start_date < now())
    and (active_end_date is null or active_end_date > now());

create view dotlrn_active_comms_not_closed
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


select define_function_args ('dotlrn_community_type__new','community_type,parent_type;dotlrn_community,pretty_name,pretty_plural,description,package_id,creation_date,creation_user,creation_ip,context_id');

select define_function_args ('dotlrn_community_type__delete','community_type');

select define_function_args ('dotlrn_community_type__name','community_type');

create function dotlrn_community_type__new (varchar,varchar,varchar,varchar,varchar)
returns varchar as '
DECLARE
        p_community_type                        alias for $1;
        p_parent_type                                alias for $2;
        p_pretty_name                                alias for $3;
        p_pretty_plural                                alias for $4;
        p_description                                alias for $5;
BEGIN
        return dotlrn_community_type__new(
            p_community_type,
            p_parent_type,
            p_pretty_name,
            p_pretty_plural,
            p_description,
            null,
            null,
            null,
            null,
            null,
        );
END;
' language 'plpgsql';

create function dotlrn_community_type__new (varchar,varchar,varchar,varchar,varchar,integer,timestamp,integer,varchar,integer)
returns varchar as '
DECLARE
        p_community_type                        alias for $1;
        p_parent_type                                alias for $2;
        p_pretty_name                                alias for $3;
        p_pretty_plural                                alias for $4;
        p_description                                alias for $5;
        p_package_id                                alias for $6;
        p_creation_date                                alias for $7;
        p_creation_user                                alias for $8;
        p_creation_ip                                alias for $9;
        p_context_id                                alias for $10;
        v_parent_object_type acs_object_types.object_type%TYPE;
        v_unique_name acs_objects.object_id%TYPE;
BEGIN
        if parent_type is null then
            v_parent_object_type:= ''group'';
        else
            v_parent_object_type:= parent_type;
        end if;

        select acs_object_id_seq.nextval
        into v_unique_name
        from dual;

        PERFORM acs_object_type__create_type (
            p_community_type,
            p_community_type,
            p_community_type,
            v_parent_object_type,
            ''dotlrn_communities'',
            ''community_id'',
            v_unique_name,
            ''acs_group.name''
        );

        insert
        into group_types
        (group_type, default_join_policy)
        values
        (p_community_type, ''closed'');

        insert
        into dotlrn_community_types
        (community_type, pretty_name, description, package_id, supertype)
        values
        (p_community_type, p_pretty_name, p_description, p_package_id, p_parent_type);

        return p_community_type;
END;
' language 'plpgsql';


create function dotlrn_community_type__delete(varchar)
returns integer as '
DECLARE
        p_community_type                alias for $1;
BEGIN
        delete
        from dotlrn_community_types
        where community_type = p_community_type;

        PERFORM acs_object_type__drop_type(p_community_type);
        return(0);
END;
' language 'plpgsql';


create function dotlrn_community_type__name(varchar)
returns varchar as '
DECLARE
        p_community_type                alias for $1;
BEGIN
        return name from dotlrn_community_types where community_type= p_community_type;
END;
' language 'plpgsql';


-- dotlrn_community

select define_function_args('dotlrn_community__new','community_id,parent_community_id,community_id,community_key,pretty_name,description,portal_id,portal_template_id,package_id,join_policy,creation_date,creation_user,creation_ip,context_id');

select define_function_args('dotlrn_community__set_active_dates','community_id,start_date,end_date');

select define_function_args('dotlrn_community__delete','community_id');

select define_function_args('dotlrn_community__name','community_id');

select define_function_args('dotlrn_community__member_p','community_id,party_id');

select define_function_args('dotlrn_community__admin_p','community_id,party_id');

select define_function_args('dotlrn_community__url','community_id');


create function dotlrn_community__new(integer,integer,varchar,varchar,varchar,varchar,integer,integer,integer,varchar,timestamp,integer,varchar,integer)
returns integer as '
DECLARE
        p_community_id                        alias for $1;
        p_parent_community_id                alias for $2;
        p_community_type                alias for $3;
        p_community_key                        alias for $4;
        p_pretty_name                        alias for $5;
        p_description                        alias for $6;
        p_portal_id                        alias for $7;
        p_portal_template_id                alias for $8;
        p_package_id                        alias for $9;
        p_join_policy                        alias for $10;
        p_creation_date                        alias for $11;
        p_creation_user                        alias for $12;
        p_creation_ip                        alias for $13;
        p_context_id                        alias for $14;
        c_id                                integer;
BEGIN
        c_id := acs_group__new (
            p_community_id,
            p_community_type,
            p_creation_date,
            p_creation_user,
            p_creation_ip,
            NULL,
            NULL,
            p_community_key,
            p_join_policy
            p_context_id,
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
           p_parent_community_id, 
           p_community_type, 
           p_community_key, 
           p_pretty_name, 
           p_description,    
           p_package_id, 
           p_portal_id, 
           p_portal_template_id);

        return c_id;        
END;
' language 'plpgsql';


create function dotlrn_community__set_active_dates(integer,date,date)
returns integer as '
DECLARE
        p_community_id                alias for $1;
        p_start_date                alias for $2;
        p_end_date                alias for $3;
BEGIN
        update dotlrn_communities
        set active_start_date = p_start_date,
            active_end_date = p_end_date
        where community_id = p_community_id;

        return p_community_id;
END;
' language 'plpgsql';

create function dotlrn_community__delete(integer)
returns integer as '
DECLARE
        p_community_id                alias for $1;
BEGIN
        delete
        from dotlrn_communities
        where community_id = p_community_id;

        PERFORM acs_group__delete(p_community_id);
        return(0);
END;
' language 'plpgsql';


create function dotlrn_community__name(integer)
returns varchar as '
DECLARE
        p_community_id                alias for $1;
BEGIN
        return acs_group__name(p_community_id);
END;
' language 'plpgsql';


create function dotlrn_community__member_p(integer,integer)
returns boolean as '
DECLARE
        p_community_id                        alias for $1;
        p_party_id                        alias for $2;
BEGIN
        -- to do (ben)
        return ''t'';
END;
' language 'plpgsql';


create function dotlrn_community__admin_p(integer,integer)
returns boolean as '
DECLARE
        p_community_id                        alias for $1;
        p_party_id                        alias for $2;
BEGIN
        IF acs_permission__permission_p(p_community_id, p_party_id, ''dotlrn_admin_community'') = ''t''
        then return ''t'';
        end if;

        IF acs_permission__permission_p(p_community_id, p_party_id, ''admin'') = ''t''
        then return ''t'';
        end if;

        return ''f'';
END;
' language 'plpgsql';


create function dotlrn_community__url(integer)
returns varchar as '
DECLARE
        p_community_id                alias for $1;
BEGIN
        return site_node__url(site_nodes.node_id)
        from dotlrn_communities,
             site_nodes
        where dotlrn_communities.community_id = p_community_id
        and site_nodes.object_id = dotlrn_communities.package_id;
END;
' language 'plpgsql';


create view dotlrn_communities_full
as
    select dotlrn_communities.*,
           dotlrn_community__url(dotlrn_communities.community_id) as url,
           groups.group_name,
           groups.join_policy
    from dotlrn_communities,
         groups
    where dotlrn_communities.community_id = groups.group_id;
