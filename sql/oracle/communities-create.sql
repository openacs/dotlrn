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
                                references dotlrn_community_types (community_type),
    portal_id                   constraint dotlrn_ct_portal_id_fk
                                references portals (portal_id)
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
    non_member_portal_id        constraint dotlrn_c_non_member_portal_fk
                                references portals (portal_id),
    admin_portal_id             constraint dotlrn_c_admin_portal_id_fk
                                references portals (portal_id),
    package_id                  constraint dotlrn_c_package_id_fk
                                references apm_packages (package_id),
    -- We can't have two communities with the same parent with the same key (url)
    -- even if the parent_community_id is null, which it will be for non-subcommunities
    constraint dotlrn_c_community_key_un
    unique (community_key, parent_community_id)
);

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
