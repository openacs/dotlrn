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
-- The DotLRN communities construct
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net
-- @author arjun (arjun@openforce.net)
-- @author dan chak (chak@openforce.net)
-- @creation-date September 20th, 2001 (redone)
-- @version $Id$
--

select define_function_args ('dotlrn_community_type__new','community_type,parent_type;dotlrn_community,pretty_name,pretty_plural,description,package_id,creation_date,creation_user,creation_ip,context_id');

select define_function_args ('dotlrn_community_type__delete','community_type');

select define_function_args ('dotlrn_community_type__name','community_type');

create or replace function dotlrn_community_type__new (varchar,varchar,varchar,varchar,varchar)
returns varchar as '
DECLARE
        p_community_type                       alias for $1;
        p_parent_type                          alias for $2;
        p_pretty_name                          alias for $3;
        p_pretty_plural                        alias for $4;
        p_description                          alias for $5;
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
            null
        );
END;
' language 'plpgsql';

create or replace function dotlrn_community_type__new (varchar,varchar,varchar,varchar,varchar,integer,timestamptz,integer,varchar,integer)
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
        if p_parent_type is null then
            v_parent_object_type:= ''application_group'';
        else
            v_parent_object_type:= p_parent_type;
        end if;

        select acs_object_id_seq.nextval
        into v_unique_name
        from dual;

        PERFORM acs_object_type__create_type (
            p_community_type,
            p_community_type,
            p_community_type,
	    v_parent_object_type,
            cast(v_unique_name as varchar),
            cast(v_unique_name as varchar),
            cast(v_unique_name as varchar),
	    ''f'',
	    null,
            ''acs_group.name''
        );

        insert
        into group_types
        (group_type, default_join_policy)
        values
        (p_community_type, ''closed'');

        insert
        into dotlrn_community_types
        (community_type, 
	 pretty_name, 
	 description, 
	 package_id, 
	 supertype)
        values
        (p_community_type, 
	 p_pretty_name, 
	 p_description, 
	 p_package_id, 
	 p_parent_type);

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

        delete
        from group_types
        where group_type = p_community_type;

        PERFORM acs_object_type__drop_type(p_community_type, ''f'');
        return 0;
END;
' language 'plpgsql';


create function dotlrn_community_type__name(varchar)
returns varchar as '
DECLARE
        p_community_type                alias for $1;
        v_name dotlrn_community_types.pretty_name%TYPE;
BEGIN
        select dotlrn_community_types.pretty_name
        into v_name
        from dotlrn_community_types
        where dotlrn_community_types.community_type = p_community_type;

        return v_name;
END;
' language 'plpgsql';


-- dotlrn_community

select define_function_args('dotlrn_community__new','community_id,parent_community_id,community_type,community_key,pretty_name,description,archived_p;f,portal_id,non_member_portal_id,package_id,join_policy,creation_date,creation_user,creation_ip,context_id');

create or replace function dotlrn_community__new(integer,integer,varchar,varchar,varchar,varchar,varchar,integer,integer,integer,varchar,timestamptz,integer,varchar,integer)
returns integer as '
DECLARE
        p_community_id                  alias for $1;
        p_parent_community_id           alias for $2;
        p_community_type                alias for $3;
        p_community_key                 alias for $4;
        p_pretty_name                   alias for $5;
        p_description                   alias for $6;
        p_archived_p                    alias for $7;
        p_portal_id                     alias for $8;
        p_non_member_portal_id          alias for $9;
        p_package_id                    alias for $10;
        p_join_policy                   alias for $11;
        p_creation_date                 alias for $12;
        p_creation_user                 alias for $13;
        p_creation_ip                   alias for $14;
        p_context_id                    alias for $15;
        c_id                            integer;
        v_group_type_exists_p           integer;
BEGIN

        c_id := application_group__new (
            p_community_id,
            p_community_type,
            p_creation_date,
            p_creation_user,
            p_creation_ip,
            null,
            null,
            p_community_key,
            p_package_id,
            p_join_policy,
            p_context_id
        );

        insert into dotlrn_communities_all
          (community_id, 
           parent_community_id,
           community_type, 
           community_key, 
           pretty_name,  
           description, 
           package_id, 
           portal_id,
           archived_p,
           non_member_portal_id)
        values
          (c_id, 
           p_parent_community_id, 
           p_community_type, 
           p_community_key, 
           p_pretty_name, 
           p_description,    
           p_package_id, 
           p_portal_id,
           p_archived_p,
           p_non_member_portal_id);

        return c_id;        
END;
' language 'plpgsql';

select define_function_args('dotlrn_community__set_active_dates','community_id,start_date,end_date');

create function dotlrn_community__set_active_dates(integer,date,date)
returns integer as '
DECLARE
        p_community_id            alias for $1;
        p_start_date              alias for $2;
        p_end_date                alias for $3;
BEGIN
        update dotlrn_communities_all
        set active_start_date = p_start_date,
            active_end_date = p_end_date
        where community_id = p_community_id;

        return p_community_id;
END;
' language 'plpgsql';

select define_function_args('dotlrn_community__delete','community_id');

create function dotlrn_community__delete(integer)
returns integer as '
DECLARE
        p_community_id                alias for $1;
BEGIN
        delete
        from dotlrn_communities
        where community_id = p_community_id;

        PERFORM acs_group__delete(p_community_id);
        return 0;
END;
' language 'plpgsql';


select define_function_args('dotlrn_community__name','community_id');

create function dotlrn_community__name(integer)
returns varchar as '
DECLARE
        p_community_id                alias for $1;
BEGIN
        return acs_group__name(p_community_id);
END;
' language 'plpgsql';


select define_function_args('dotlrn_community__member_p','community_id,party_id');

create function dotlrn_community__member_p(integer,integer)
returns boolean as '
DECLARE
        p_community_id                    alias for $1;
        p_party_id                        alias for $2;
        v_member_p			  char(1);
BEGIN
       select CASE 
		   WHEN count(*) = 0
		   THEN ''f''
		   ELSE ''t''
	      END
        into v_member_p
        from dual
        where exists (select 1
                      from dotlrn_member_rels_approved
                      where dotlrn_member_rels_approved.user_id = dotlrn_community.member_p.party_id
                      and dotlrn_member_rels_approved.community_id = dotlrn_community.member_p.community_id);

        return v_member_p;

END;
' language 'plpgsql';


select define_function_args('dotlrn_community__admin_p','community_id,party_id');

create function dotlrn_community__admin_p(integer,integer)
returns boolean as '
DECLARE
        p_community_id                    alias for $1;
        p_party_id                        alias for $2;
        r_rv				  char(1);
BEGIN
	-- THIS NEEDS TO BE CHECKED!
	-- chak, 2002-07-01
	select CASE
		WHEN acs_permission__permission_p(p_community_id, p_party_id, ''dotlrn_admin_community'') = ''f''
		THEN acs_permission__permission_p(p_community_id,p_party_id,''admin'')
		ELSE ''t''	
	     END
	   into r_rv
           from dual;

	return r_rv;
END;
' language 'plpgsql';


select define_function_args('dotlrn_community__url','community_id');

create function dotlrn_community__url(integer)
returns varchar as '
DECLARE
        p_community_id                alias for $1;
        v_node_id		      site_nodes.node_id%TYPE;
BEGIN
        select site_nodes.node_id into v_node_id
        from dotlrn_communities_all,
             site_nodes
        where dotlrn_communities_all.community_id = p_community_id
        and site_nodes.object_id = dotlrn_communities_all.package_id;

	return site_node__url(v_node_id);

--        exception
--            when no_data_found then
--                return '';
END;
' language 'plpgsql';


create function dotlrn_community__has_subcomm_p(integer)
returns varchar as '
DECLARE
	p_community_id		alias for $1;
	r_rv char(1);
BEGIN
	select CASE
		WHEN count(*) = 0
		THEN ''f''
		ELSE ''t''
	       END
	  into r_rv
	  from dual 
         where dotlrn_communities_all.community_id = p_community_id;
	 
	 return r_rv;
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
