--
-- The DotLRN basic system
-- copyright 2001, OpenForce, inc.
-- distributed under the GNU GPL v2
--
-- for PG 7.1.3        
--
-- @author Ben Adida (ben@openforce.net)
-- @author yon (yon@openforce.net)
-- @creation-date 2001-08-18
-- @version $Id$
--

create table dotlrn_departments (
    department_key              varchar(100) 
                                constraint dotlrn_departments_dept_key_fk
                                references dotlrn_community_types (community_type)
                                constraint dotlrn_departments_pk
                                primary key,
    external_url                varchar(250)
);

create view dotlrn_departments_full
as
    select dotlrn_departments.department_key,
           dotlrn_community_types.pretty_name,
           dotlrn_community_types.description,
           dotlrn_community_types.package_id,
           dotlrn_community_types.supertype,
           (select site_node__url(site_nodes.node_id)
            from site_nodes
            where site_nodes.object_id = dotlrn_community_types.package_id) as url,
           dotlrn_departments.external_url
    from dotlrn_departments,
         dotlrn_community_types
    where dotlrn_departments.department_key = dotlrn_community_types.community_type;

create table dotlrn_terms (
    term_id                     integer
                                constraint dotlrn_terms_pk
                                primary key,
    term_name                   varchar(20)
                                constraint dotlrn_t_term_name_nn
                                not null,
    term_year                   varchar(4)
                                constraint dotlrn_t_term_year_nn
                                not null,
    start_date                  date
                                default now()
                                constraint dotlrn_t_start_date_nn
                                not null,
    end_date                    date
                                default (now() + '180 days'::timespan)
                                constraint dotlrn_t_end_date_nn
                                not null
);

create table dotlrn_classes (
    class_key                   varchar(100) constraint dotlrn_classes_class_key_fk
                                references dotlrn_community_types (community_type)
                                constraint dotlrn_classes_pk
                                primary key,
    department_key              varchar(100) constraint dotlrn_classes_dept_key_fk
                                references dotlrn_departments (department_key)
                                constraint dotlrn_classes_dept_key_nn
                                not null
);

create view dotlrn_classes_full
as
    select dotlrn_classes.class_key,
           dotlrn_community_types.pretty_name,
           dotlrn_community_types.description,
           dotlrn_community_types.package_id,
           dotlrn_community_types.supertype,
           (select site_node__url(site_nodes.node_id)
            from site_nodes
            where site_nodes.object_id = dotlrn_community_types.package_id) as url,
           dotlrn_classes.department_key
    from dotlrn_classes,
         dotlrn_community_types
    where dotlrn_classes.class_key = dotlrn_community_types.community_type;

create table dotlrn_class_instances (
    class_instance_id           integer constraint dotlrn_ci_class_instance_id_fk
                                references dotlrn_communities (community_id)
                                constraint dotlrn_class_instances_pk
                                primary key,
    class_key                   varchar(100) constraint dotlrn_ci_class_key_fk
                                references dotlrn_classes (class_key)
                                constraint dotlrn_ci_class_key_nn
                                not null,
    term_id                     integer constraint dotlrn_ci_term_id_fk
                                references dotlrn_terms (term_id)
                                constraint dotlrn_ci_term_id_nn
                                not null
);

create view dotlrn_class_instances_full
as
    select dotlrn_class_instances.class_instance_id,
           dotlrn_class_instances.class_key,
           dotlrn_class_instances.term_id,
           dotlrn_terms.term_name,
           dotlrn_terms.term_year,
           dotlrn_terms.start_date,
           dotlrn_terms.end_date,
           dotlrn_communities.community_type,
           dotlrn_communities.community_key,
           dotlrn_communities.pretty_name,
           dotlrn_communities.description,
           dotlrn_communities.active_start_date,
           dotlrn_communities.active_end_date,
           dotlrn_communities.portal_id,
           dotlrn_communities.portal_template_id,
           dotlrn_communities.package_id,
           dotlrn_community__url(dotlrn_communities.community_id) as url,
           dotlrn_classes_full.pretty_name as class_name,
           dotlrn_classes_full.url as class_url,
           dotlrn_classes_full.department_key,
           dotlrn_departments_full.pretty_name as department_name,
           dotlrn_departments_full.url as department_url,
           groups.join_policy
    from dotlrn_communities,
         dotlrn_class_instances,
         dotlrn_terms,
         dotlrn_classes_full,
         dotlrn_departments_full,
         groups
    where dotlrn_communities.community_id = dotlrn_class_instances.class_instance_id
    and dotlrn_class_instances.term_id = dotlrn_terms.term_id
    and dotlrn_communities.community_type = dotlrn_classes_full.class_key
    and dotlrn_classes_full.department_key = dotlrn_departments_full.department_key
    and dotlrn_communities.community_id = groups.group_id;

create view dotlrn_class_instances_current
as
    select *
    from dotlrn_class_instances_full
    where now() between active_start_date and active_end_date;

create view dotlrn_class_instances_not_old
as
    select *
    from dotlrn_class_instances_full
    where active_end_date >= now();


select define_function_args ('dotlrn_department__new','department_key,pretty_name,pretty_plural,description,package_id,creation_date,creation_user,creation_ip,context_id');

select define_function_args ('dotlrn_department__delete', 'department_key');


create function dotlrn_department__new(varchar,varchar,varchar,varchar,integer,timestamp,integer,varchar,integer)
returns varchar as '
DECLARE
        p_department_key                        alias for $1;
        p_pretty_name                                alias for $2;
        p_pretty_plural                                alias for $3;
        p_description                                alias for $4;
        p_package_id                                alias for $5;
        p_creation_date                                alias for $6;
        p_creation_user                                alias for $7;
        p_creation_ip                                alias for $8;
        p_context_id                                alias for $9;
        v_department_key dotlrn_departments.department_key%TYPE;
BEGIN
        v_department_key := dotlrn_community_type__new (
            p_department_key,
            ''dotlrn_class_instance'',
            p_pretty_name,
            p_pretty_plural,
            p_description,
            p_package_id,
            p_creation_date,
            p_creation_user,
            p_creation_ip,
            p_context_id
        );

        insert
        into dotlrn_departments
        (department_key) values (v_department_key);

        return v_department_key;
END;
' language 'plpgsql';


create function dotlrn_department__delete(varchar)
returns integer as '
DECLARE
        p_department_key                alias for $1;
BEGIN
        delete
        from dotlrn_departments
        where department_key = p_department_key;

        PERFORM dotlrn_community_type__delete(p_department_key);
        return(0);
END;
' language 'plpgsql';


select define_function_args('dotlrn_class__new','class_key,department_key,pretty_name,pretty_plural,description,package_id,creation_date,creation_user,creation_ip,context_id');

select define_function_args('dotlrn_class__delete','class_key');


create function dotlrn_class__new(varchar,varchar,varchar,varchar,varchar,integer,timestamp,integer,varchar,integer)
returns varchar as '
DECLARE
        p_class_key                        alias for $1;
        p_department_key                alias for $2;
        p_pretty_name                        alias for $3;
        p_pretty_plural                        alias for $4;
        p_description                        alias for $5;
        p_package_id                        alias for $6;
        p_creation_date                        alias for $7;
        p_creation_user                        alias for $8;
        p_creation_ip                        alias for $9;
        p_context_id                        alias for $10;
        v_class_key dotlrn_classes.class_key%TYPE;
BEGIN
        v_class_key := dotlrn_community_type__new (
            p_class_key,
            p_department_key,
            p_pretty_name,
            p_pretty_plural,
            p_description,
            p_package_id,
            p_creation_date,
            p_creation_user,
            p_creation_ip,
            p_context_id
        );

        insert
        into dotlrn_classes
        (class_key, department_key) values (v_class_key, p_department_key);

        return v_class_key;
END;
' language 'plpgsql';


create function dotlrn_class__delete(varchar)
returns integer as '
DECLARE
        p_class_key                alias for $1;
BEGIN
        delete
        from dotlrn_classes
        where class_key = p_class_key;

        PERFORM dotlrn_community_type__delete(p_class_key);
        return(0);
END;
' language 'plpgsql';



select define_function_args('dotlrn_class_instance__new','class_instance_id,class_key,term_id,community_key,pretty_name,description,package_id,portal_id,portal_template_id,join_policy,creation_date,creation_user,creation_ip,context_id');

select define_function_args('dotlrn_class_instance__delete','class_instance_id');


create function dotlrn_class_instance__new(integer,varchar,integer,varchar,varchar,varchar,integer,integer,integer,varchar,timestamp,integer,varchar,integer)
returns integer as '
DECLARE
        p_class_instance_id                        alias for $1;
        p_class_key                                alias for $2;
        p_term_id                                alias for $3;
        p_community_key                                alias for $4;
        p_pretty_name                                alias for $5;
        p_description                                alias for $6;
        p_package_id                                alias for $7;
        p_portal_id                                alias for $8;
        p_portal_template_id                        alias for $9;
        p_join_policy                                alias for $10;
        p_creation_date                                alias for $11;
        p_creation_user                                alias for $12;
        p_creation_ip                                alias for $13;
        p_context_id                                alias for $14;
        v_class_instance_id dotlrn_class_instances.class_instance_id%TYPE;
BEGIN
        v_class_instance_id := dotlrn_community__new (
            p_class_instance_id,
            p_class_key,
            p_community_key,
            p_pretty_name,
            p_description,
            p_package_id,
            p_portal_id,
            p_portal_template_id,
            p_join_policy,
            p_creation_date,
            p_creation_user,
            p_creation_ip,
            p_context_id
        );

        insert
        into dotlrn_class_instances
        (class_instance_id, class_key, term_id)
        values
        (v_class_instance_id, p_class_key, p_term_id);

        return v_class_instance_id;
END;
' language 'plpgsql';


create function dotlrn_class_instance__delete(integer)
returns integer as '
DECLARE
        p_class_instance_id                alias for $1;
BEGIN
        delete
        from dotlrn_class_instances
        where class_instance_id= p_class_instance_id;

        PERFORM dotlrn_community__delete(p_class_instance_id);
        return(0);
END;
' language 'plpgsql';

