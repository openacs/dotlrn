
--
-- The DotLRN memberships packages
-- copyright 2001, OpenForce, Inc.
-- distributed under the GNU GPL v2
--
-- for Oracle 8/8i. (We're guessing 9i works, too).
-- ported to PG by Yon and Ben
--
-- ben@openforce.net
-- started November 6th, 2001
--

--
-- Basic dotLRN membership rel
--

select define_function_args('dotlrn_member_rel__new','rel_id,rel_type;dotlrn_member_rel,portal_id,community_id,user_id,member_state;approved,creation_user,creation_ip');

select define_function_args('dotlrn_member_rel__delete','rel_id');


create function dotlrn_member_rel__new(integer,varchar,integer,integer,integer,varchar,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_portal_id             alias for $3;
        p_community_id          alias for $4;
        p_user_id               alias for $5;
        p_member_state          alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= membership_rel__new(
            p_rel_id,
            p_rel_type,
            p_community_id,
            p_user_id,
            p_member_state,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_member_rels
        (rel_id, portal_id)
        values
        (v_rel_id, p_portal_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_member_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete from dotlrn_member_rels where rel_id= p_rel_id;

        PERFORM membership_rel__delete(p_rel_id);

        return 0;
END;
' language 'plpgsql';



select define_function_args('dotlrn_admin_rel__new','rel_id,rel_type;dotlrn_admin_rel,community_id,user_id,member_state,portal_id,creation_user,creation_ip');

select define_function_args('dotlrn_admin_rel__delete','rel_id');

create function dotlrn_admin_rel__new(integer,varchar,integer,integer,varchar,integer,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_community_id          alias for $3;
        p_user_id               alias for $4;
        p_member_state          alias for $5;
        p_portal_id             alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= dotlrn_member_rel__new(
            p_rel_id,
            p_rel_type,
            p_portal_id,
            p_community_id,
            p_user_id,
            p_member_state,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_admin_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_admin_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete from dotlrn_admin_rels where rel_id= p_rel_id;

        PERFORM dotlrn_admin_rel__delete(p_rel_id);

        return 0;
END;
' language 'plpgsql';


select define_function_args('dotlrn_student_rel__new','rel_id,rel_type;dotlrn_student_rel,portal_id,class_instance_id,user_id,member_state,creation_user,creation_ip');

select define_function_args('dotlrn_student_rel__delete','rel_id');

create function dotlrn_student_rel__new(integer,varchar,integer,integer,integer,varchar,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_portal_id             alias for $3;
        p_class_instance_id     alias for $4;
        p_user_id               alias for $5;
        p_member_state          alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= dotlrn_member_rel__new(
            p_rel_id,
            p_rel_type,
            p_portal_id,
            p_class_instance_id,
            p_user_id,
            p_member_state,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_student_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_student_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete from dotlrn_student_rels where rel_id= p_rel_id;

        PERFORM dotlrn_member_rel__delete(p_rel_id);

        return 0;
END;
' language 'plpgsql';



select define_function_args('dotlrn_ta_rel__new','rel_id,rel_type;dotlrn_ta_rel,class_instance_id,user_id,member_state,portal_id,creation_user,creation_ip');

select define_function_args('dotlrn_ta_rel__delete','rel_id');


create function dotlrn_ta_rel__new(integer,varchar,integer,integer,varchar,integer,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_class_instance_id     alias for $3;
        p_user_id               alias for $4;
        p_member_state          alias for $5;
        p_portal_id             alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= dotlrn_admin_rel__new(
            p_rel_id,
            p_rel_type,
            p_class_instance_id,
            p_user_id,
            p_member_state,
            p_portal_id,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_ta_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_ta_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete
        from dotlrn_ta_rels
        where rel_id = p_rel_id;

        PERFORM dotlrn_admin_rel__delete(rel_id);
        
        return 0;
END;
' language 'plpgsql';


-- ca rel

select define_function_args('dotlrn_ca_rel__new','rel_id,rel_type;dotlrn_ca_rel,class_instance_id,user_id,member_state,portal_id,creation_user,creation_ip');

select define_function_args('dotlrn_ca_rel__delete','rel_id');


create function dotlrn_ca_rel__new(integer,varchar,integer,integer,varchar,integer,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_class_instance_id     alias for $3;
        p_user_id               alias for $4;
        p_member_state          alias for $5;
        p_portal_id             alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= dotlrn_admin_rel__new(
            p_rel_id,
            p_rel_type,
            p_class_instance_id,
            p_user_id,
            p_member_state,
            p_portal_id,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_ca_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_ca_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete
        from dotlrn_ca_rels
        where rel_id = p_rel_id;

        PERFORM dotlrn_admin_rel__delete(rel_id);
        
        return 0;
END;
' language 'plpgsql';


-- course admin

select define_function_args('dotlrn_cadmin_rel__new','rel_id,rel_type;dotlrn_cadmin_rel,class_instance_id,user_id,member_state,portal_id,creation_user,creation_ip');

select define_function_args('dotlrn_cadmin_rel__delete','rel_id');


create function dotlrn_cadmin_rel__new(integer,varchar,integer,integer,varchar,integer,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_class_instance_id     alias for $3;
        p_user_id               alias for $4;
        p_member_state          alias for $5;
        p_portal_id             alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= dotlrn_admin_rel__new(
            p_rel_id,
            p_rel_type,
            p_class_instance_id,
            p_user_id,
            p_member_state,
            p_portal_id,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_cadmin_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_cadmin_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete
        from dotlrn_cadmin_rels
        where rel_id = p_rel_id;

        PERFORM dotlrn_admin_rel__delete(rel_id);
        
        return 0;
END;
' language 'plpgsql';


-- instructor rel

select define_function_args('dotlrn_instructor_rel__new','rel_id,rel_type;dotlrn_instructor_rel,class_instance_id,user_id,member_state,portal_id,creation_user,creation_ip');

select define_function_args('dotlrn_instructor_rel__delete','rel_id');


create function dotlrn_instructor_rel__new(integer,varchar,integer,integer,varchar,integer,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_rel_type              alias for $2;
        p_class_instance_id     alias for $3;
        p_user_id               alias for $4;
        p_member_state          alias for $5;
        p_portal_id             alias for $6;
        p_creation_user         alias for $7;
        p_creation_ip           alias for $8;
        v_rel_id                integer;
BEGIN
        v_rel_id:= dotlrn_admin_rel__new(
            p_rel_id,
            p_rel_type,
            p_class_instance_id,
            p_user_id,
            p_member_state,
            p_portal_id,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_instructor_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_instructor_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete
        from dotlrn_instructor_rels
        where rel_id = p_rel_id;

        PERFORM dotlrn_admin_rel__delete(rel_id);
        
        return 0;
END;
' language 'plpgsql';

