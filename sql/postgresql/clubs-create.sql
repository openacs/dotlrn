--
--  Copyright (C) 2001, 2002 MIT
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
-- The dotLRN basic system
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @author dan chak (chak@openforce.net)
-- @creation-date August 18th, 2001
-- @version $Id$
--

create table dotlrn_clubs (
    club_id                     integer
                                constraint dotlrn_clubs_club_id_fk
                                references dotlrn_communities_all (community_id)
                                constraint dotlrn_clubs_pk
                                primary key
);

create view dotlrn_clubs_full
as
    select dotlrn_clubs.club_id,
	   dotlrn_communities.*,
           dotlrn_community__url(dotlrn_communities.community_id::integer) as url,
           groups.join_policy
    from dotlrn_communities,
         dotlrn_clubs,
         groups
    where dotlrn_communities.community_id = dotlrn_clubs.club_id
    and dotlrn_communities.community_id = groups.group_id;


select define_function_args ('dotlrn_club__new','club_id,community_key,pretty_name,description,package_id,portal_id,non_member_portal_id,join_policy,creation_date,creation_user,creation_ip,context_id');

select define_function_args ('dotlrn_club__delete','club_id');


create function dotlrn_club__new(integer,varchar,varchar,varchar,integer,integer,integer,varchar,timestamptz,integer,varchar,integer)
returns integer as '
DECLARE
        p_club_id                        alias for $1;
        p_community_key                  alias for $2;
        p_pretty_name                    alias for $3;
        p_description                    alias for $4;
        p_package_id                     alias for $5;
        p_portal_id                      alias for $6;
        p_non_member_portal_id           alias for $7;
        p_join_policy                    alias for $8;
        p_creation_date                  alias for $9;
        p_creation_user                  alias for $10;
        p_creation_ip                    alias for $11;
        p_context_id                     alias for $12;
        v_club_id                        integer;
BEGIN
        v_club_id := dotlrn_community__new(
            p_club_id,
            null,
            ''dotlrn_club'',
            p_community_key,
            p_pretty_name,
            p_description,
            ''f'',
            p_portal_id,
            p_non_member_portal_id,
            p_package_id,
            p_join_policy,
            p_creation_date,
            p_creation_user,
            p_creation_ip,
            p_context_id
        );

        insert
        into dotlrn_clubs (club_id)
        values (v_club_id);

        return v_club_id;
END;
' language 'plpgsql';


create function dotlrn_club__delete(integer)
returns integer as '
DECLARE
        p_club_id                alias for $1;
BEGIN
        delete
        from dotlrn_clubs
        where club_id = p_club_id;

        PERFORM dotlrn_community__delete(p_club_id);
        return(0);
END;
' language 'plpgsql';

