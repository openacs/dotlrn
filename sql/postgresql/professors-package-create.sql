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
-- Create the Professor package
--
-- @author <a href="mailto:yon@openforce.net">yon@openforce.net</a>
-- @version $Id$
--

select define_function_args ('dotlrn_professor_profile_rel__new','rel_id,user_id,portal_id,theme_id,id,rel_type;dotlrn_professor_profile_rel,group_id,creation_user,creation_ip');

select define_function_args ('dotlrn_professor_profile_rel__delete','rel_id');


create function dotlrn_professor_profile_rel__new(integer,integer,integer,integer,integer,integer,integer,varchar)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
        p_user_id               alias for $2;
	p_portal_id		alias_for $3;
	p_theme_id		alias_for $4;
	p_id			alias_for $5;
        p_rel_type              alias for $6;
        p_group_id              alias for $7;
        p_creation_user         alias for $8;
        p_creation_ip           alias for $9;
        v_rel_id                dotlrn_user_profile_rels.rel_id%TYPE;
        v_group_id              groups.group_id%TYPE;
BEGIN
        if p_group_id is null then
            select min(group_id)
            into v_group_id
            from profiled_groups
            where profile_provider = (select min(impl_id)
                                      from acs_sc_impls
                                      where impl_name = ''dotlrn_professor_profile_provider'');
        else
             v_group_id := p_group_id;
        end if;

        v_rel_id := dotlrn_user_profile_rel__new(
            p_rel_id,
	    p_user_id,
	    p_portal_id,
	    p_theme_id,
            p_id,
            p_rel_type,
            v_group_id,
            p_creation_user,
            p_creation_ip
        );

        insert
        into dotlrn_professor_profile_rels
        (rel_id)
        values
        (v_rel_id);

        return v_rel_id;
END;
' language 'plpgsql';


create function dotlrn_professor_profile_rel__delete(integer)
returns integer as '
DECLARE
        p_rel_id                alias for $1;
BEGIN
        delete
        from dotlrn_professor_profile_rels
        where rel_id = p_rel_id;

        PERFORM dotlrn_user_profile_rel__delete(p_rel_id);        
        return (0);
END;
' language 'plpgsql';


