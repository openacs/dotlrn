
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

