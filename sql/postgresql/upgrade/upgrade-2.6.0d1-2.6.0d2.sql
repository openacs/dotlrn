-- 
-- 
-- 
-- @author Victor Guerra (vguerra@gmail.com)
-- @creation-date 2010-11-08
-- @cvs-id $Id$
--

-- PG 9.0 compatibility. Changes regarding usage of sequences.

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

        select nextval(''t_acs_object_id_seq'')
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

